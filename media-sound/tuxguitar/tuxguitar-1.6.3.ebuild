# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit xdg

DESCRIPTION="TuxGuitar is a multitrack guitar tablature editor and player written in Java-SWT"
HOMEPAGE="http://www.tuxguitar.com.ar/"
SRC_URI="https://github.com/helge17/tuxguitar/archive/refs/tags/1.6.3.tar.gz -> tuxguitar-1.6.3.tar.gz
	https://github.com/domichel/GenCool/raw/master/distfiles/tuxguitar-1.6.3_bdepends.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="alsa -fluidalsa -fluidjack -fluidsdl -fluidoss -fluidpipewire -fluidportaudio -fluidpulseaudio fluidsynth oss timidity"

KEYWORDS="~amd64 ~x86"
CDEPEND="dev-java/swt:4.10[cairo]
	>=dev-qt/qtbase-6.6
	media-libs/lilv
	media-libs/suil
	>=net-libs/webkit-gtk-2.42
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

BDEPEND="dev-java/maven-bin"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"
BDEPEND="${DEPEND}
	app-arch/unzip
	dev-java/maven-bin"

PATCHES=( "${FILESDIR}"/replace-soundfont_1.6.3.patch )
#S="${WORKDIR}/${PN}-1.6.3"

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
	unpack tuxguitar-1.6.3.tar.gz
	# emerge don't have access to the network. To make this archive, as a regular user,
	# unpack tuxguitar archive, go into the wanted build-script directory and run
	# 	mvn -e clean verify -P native-modules
	# The downloaded bdepends will be into $HOME/.m2
	# Add .m2/repository/settings.xml from the preceding version archive and pack the .m2 directory.
	# Edit the following sed call if the $HOME value is not the same.
	unpack tuxguitar-1.6.3_bdepends.tar.bz2
	sed -i -e "s:/home/dom/softs/Gentoo/TuxGuitar/.m2:${WORKDIR}/.m2/repository:" "${WORKDIR}"/.m2/repository/settings.xml
	# VST2 is deprecated, use only native software
}

src_compile() {
	cd "${S}/desktop/build-scripts/tuxguitar-linux-swt"
	mvn -e clean verify -s "${WORKDIR}"/.m2/repository/settings.xml -P native-modules
	cd "${S}"
	sed -i -e "s:Icon=.*:Icon=tuxguitar:" desktop/build-scripts/tuxguitar-linux-swt/target/tuxguitar-9.99-SNAPSHOT-linux-swt/share/applications/tuxguitar.desktop
	rm desktop/build-scripts/tuxguitar-linux-swt/target/tuxguitar-9.99-SNAPSHOT-linux-swt/doc/INSTALL.md
	rm desktop/build-scripts/tuxguitar-linux-swt/target/tuxguitar-9.99-SNAPSHOT-linux-swt/doc/LICENSE
	# The default audio driver is hardcoded, set it to the one the user want to use:
	DRIVERF="desktop/build-scripts/tuxguitar-linux-swt/target/tuxguitar-9.99-SNAPSHOT-linux-swt/dist/tuxguitar-fluidsynth.cfg"
	if use fluidalsa; then sed -i -e "s:pulseaudio:alsa:" "${DRIVERF}"; fi
	if use fluidjack; then sed -i -e "s:pulseaudio:jack:" "${DRIVERF}"; fi
	if use fluidsdl; then sed -i -e "s:pulseaudio:sdl2:" "${DRIVERF}"; fi
	if use fluidoss; then sed -i -e "s:pulseaudio:oss:" "${DRIVERF}"; fi
	if use fluidpipewire; then sed -i -e "s:pulseaudio:pipewire:" "${DRIVERF}"; fi
	if use fluidportaudio; then sed -i -e "s:pulseaudio:portaudio:" "${DRIVERF}"; fi
}

src_install() {
	cd "${S}/desktop/build-scripts/tuxguitar-linux-swt/target/tuxguitar-9.99-SNAPSHOT-linux-swt"
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
