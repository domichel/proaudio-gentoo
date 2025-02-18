# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit xdg

# TODO: help needed, build using java instead of marvem, see
#    https://bugs.gentoo.org/show_bug.cgi?id=914890#c16

DESCRIPTION="TuxGuitar is a multitrack guitar tablature editor and player written in Java-SWT"
HOMEPAGE="https://www.tuxguitar.app/"
SRC_URI="https://github.com/helge17/tuxguitar/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	amd64? ( https://archive.eclipse.org/eclipse/downloads/drops4/R-4.26-202211231800/swt-4.26-gtk-linux-x86_64.zip )"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="alsa fluidalsa fluidjack fluidsdl fluidoss fluidpipewire fluidportaudio fluidpulseaudio fluidsynth html oss timidity"

KEYWORDS="~amd64"
RESTRICT="network-sandbox"
CDEPEND=">=dev-java/swt-4.26[cairo]
	>=dev-qt/qtbase-6.6
	media-libs/lilv
	media-libs/suil
	html? ( >=net-libs/webkit-gtk-2.42 )
	alsa? ( media-libs/alsa-lib )
	fluidsynth? ( media-sound/fluidsynth )
	fluidalsa? ( media-sound/fluidsynth[alsa] )
	fluidjack? ( media-sound/fluidsynth[jack] )
	fluidsdl? ( media-sound/fluidsynth[sdl] )
	fluidoss? ( media-sound/fluidsynth[oss] )
	fluidpipewire? ( media-sound/fluidsynth[pipewire] )
	fluidportaudio? ( media-sound/fluidsynth[portaudio] )
	fluidpulseaudio? ( media-sound/fluidsynth[pulseaudio] )"
	# itext not in main tree
	#pdf? ( dev-java/itext:0 )"
RDEPEND=">=virtual/jre-1.5
	media-sound/fluid-soundfont
	timidity? (
		alsa? ( media-sound/timidity++[alsa] )
		oss? ( media-sound/timidity++[oss] )
		media-sound/timidity++
	)
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"
BDEPEND="${DEPEND}
	app-arch/unzip
	dev-java/maven-bin"

PATCHES=( "${FILESDIR}"/replace-soundfont_${PV}.patch )
BUILDSCRIPTD="desktop/build-scripts/tuxguitar-linux-swt"
TARGETD="target/tuxguitar-9.99-SNAPSHOT-linux-swt"

check_extra_config() {
	eerror	"The USE flags fluidalsa, fluidjack, fluidsdl,"
	eerror	"fluidoss, fluidpipewire, fluidportaudio, and"
	eerror	"fluidpulseaudio are used to set the hardcoded audio driver"
	eerror	"${PN} will use with fluidsynth."
	eerror	'It is mandatory, with USE="fluidsynth", to'
	eerror	"specify one of these and only one of them."
	eerror	"The wanted driver must be runing and available"
	eerror	"if you want sound with the fluisynth plugin."
	eerror	"Please change your USE flags accordingly."
	die	"Wrong USE flags. Aborting..."
}

pkg_pretend() {
	if use fluidsynth; then
		let i=0
		if use fluidalsa; then let i+=1; fi
		if use fluidjack; then let i+=1; fi
		if use fluidsdl; then let i+=1; fi
		if use fluidoss; then let i+=1; fi
		if use fluidpipewire; then let i+=1; fi
		if use fluidportaudio; then let i+=1; fi
		if use fluidpulseaudio; then let i+=1; fi
		if [[ "${i}" -ge "2" ]] || [[ "${i}" -eq "0" ]] ; then
			CONFIG_CHECK="FLUIDSYNTH"
			ERROR_FLUIDSYNTH="Wrong USE flags."
			check_extra_config
		fi
	fi
}

src_unpack() {
	unpack ${P}.tar.gz
	if use amd64 ; then
		mkdir swt-4.26-gtk-linux-x86_64 || die "mkdir failed"
		cd swt-4.26-gtk-linux-x86_64 || die "cd failed"
		unpack swt-4.26-gtk-linux-x86_64.zip
	fi
	mkdir -p "${WORKDIR}"/.m2/repository/ || die "sed mkdir failed"
	cp "${FILESDIR}/settings.xml" "${WORKDIR}"/.m2/repository/settings.xml || die "cp failed"
	sed -i -e "s:/home/dom/softs/Gentoo/TuxGuitar/.m2:${WORKDIR}/.m2/repository:" \
		"${WORKDIR}"/.m2/repository/settings.xml || die "sed 1 failed"
	# VST2 is deprecated, use only native software
}

src_compile() {
	if use amd64 ; then
		cd "${WORKDIR}"/swt-4.26-gtk-linux-x86_64 || die "cd failed"
		mvn install:install-file -s "${WORKDIR}"/.m2/repository/settings.xml -Dfile=swt.jar -DgroupId=org.eclipse.swt \
			-DartifactId=org.eclipse.swt.gtk.linux -Dpackaging=jar -Dversion=4.26 || die "mvn swt failed"
	fi
	cd "${S}/${BUILDSCRIPTD}" || die "cd build script failed"
	ewarn "FEATURE 'network-sandbox' breaks maven downloads so it was disabled !"
	mvn -e clean verify -s "${WORKDIR}"/.m2/repository/settings.xml -P native-modules || die "mvn failed"
	cd "${S}"
	sed -i -e "s:Icon=.*:Icon=tuxguitar:" \
		"${BUILDSCRIPTD}/${TARGETD}"/share/applications/tuxguitar.desktop \
		|| die "sed 2 failed"
	rm "${BUILDSCRIPTD}/${TARGETD}"/doc/INSTALL.md \
		|| die "rm 1 failed"
	rm "${BUILDSCRIPTD}/${TARGETD}"/doc/LICENSE || die "rm 2 failed"
	# The default audio driver is hardcoded, set it to the one the user want to use:
	DRIVERF="${BUILDSCRIPTD}/${TARGETD}/dist/tuxguitar-fluidsynth.cfg"
	if use fluidalsa; then sed -i -e "s:pulseaudio:alsa:" "${DRIVERF}" || die "sed driver failed" ; fi
	if use fluidjack; then sed -i -e "s:pulseaudio:jack:" "${DRIVERF}" || die "sed driver failed"; fi
	if use fluidsdl; then sed -i -e "s:pulseaudio:sdl2:" "${DRIVERF}" || die "sed driver failed"; fi
	if use fluidoss; then sed -i -e "s:pulseaudio:oss:" "${DRIVERF}" || die "sed driver failed"; fi
	if use fluidpipewire; then sed -i -e "s:pulseaudio:pipewire:" "${DRIVERF}" || die "sed driver failed"; fi
	if use fluidportaudio; then sed -i -e "s:pulseaudio:portaudio:" "${DRIVERF}" || die "sed driver failed"; fi
}

src_install() {
	cd "${S}/${BUILDSCRIPTD}/${TARGETD}" \
		|| die "cd install dir failed"
	insinto /usr/share/tuxguitar
	doins tuxguitar.sh
	doins -r dist
	doins -r share/help
	doins -r share/lang
	doins -r lib
	doins -r lv2-client
	doins -r share/plugins
	doins -r share/scales
	doins -r share/skins
	doins -r share/templates
	doins -r share/tunings
	# the replace-soundfont patch makes tuxguitar to use the font from fluid-soundfont, but as this one
	# don't collide with files from existing packages, install it into Gentoo specific location:
	insinto /usr/share/sounds/sf2
	doins share/soundfont/*.sf2
	insinto /usr/share
	doins -r share/applications
	doins -r share/man
	doins -r share/mime
	doins -r share/pixmaps
	insopts -m 755
	dobin "${FILESDIR}"/tuxguitar
	dodoc -r doc/*
	einstalldocs

	if use fluidsynth; then
		ewarn "Fluidsynth plugin blocks behavior of JSA plugin."
		ewarn "Enable only one of them in \"Tools > Plugins\""
		ewarn "Fuildsynth plugin is the only synth with a font"
		ewarn "preference dialog. For this feature,"
		ewarn "${P} must be merged with USE=\"fluidsynth\"."
	fi
}
