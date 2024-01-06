# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit xdg

DESCRIPTION="TuxGuitar is a multitrack guitar tablature editor and player written in Java-SWT"
HOMEPAGE="http://www.tuxguitar.com.ar/"
SRC_URI="https://github.com/helge17/tuxguitar/archive/refs/tags/1.6.0.tar.gz -> tuxguitar-1.6.0.tar.gz
	https://github.com/domichel/GenCool/raw/master/distfiles/tuxguitar-1.6.0_bdepends.tar.bz2
	https://archive.eclipse.org/eclipse/downloads/drops4/R-4.13-201909161045/swt-4.13-gtk-linux-x86_64.zip"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="alsa -fluidalsa -fluidjack -fluidsdl -fluidoss -fluidpipewire -fluidportaudio -fluidpulseaudio fluidsynth oss timidity"

KEYWORDS="~amd64 ~x86"
CDEPEND="dev-java/swt:4.10[cairo]
	media-libs/suil
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

PATCHES=( "${FILESDIR}"/replace-soundfont.patch )

src_unpack() {
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
			eerror "The Use flags fluidalsa, fluidjack, fluidsdl,"
			eerror "fluidoss fluidpipewire fluidportaudio and"
			eerror "fluidpulseaudio are used to set the audio driver"
			eerror "${PN} will use for fluidsynth."
			eerror 'It is mandatory, with USE="fluidsynth", to'
			eerror "specify one of these and only one of them."
			eerror "The wanted driver must be runing and available"
			eerror "if you want sound with the fluisynth plugin."
			die "wrong use flags"
		fi
	fi

	local SWTN="swt-4.13-gtk-linux-x86_64"
	local SWT_DIR="${WORKDIR}/swt-4.13-gtk-linux-x86_64"
	unpack tuxguitar-1.6.0.tar.gz
	unpack tuxguitar-1.6.0_bdepends.tar.bz2
	mkdir -p "${SWT_DIR}"
	cd "${SWT_DIR}"
	unpack "${SWTN}".zip
	sed -i -e "s:/home/dom/softs/Gentoo/TuxGuitar/.m2:${WORKDIR}/.m2:" "${WORKDIR}"/.m2/settings.xml
	mkdir "${S}/build-scripts/native-modules/tuxguitar-synth-vst-linux-x86_64/include"
	cd "${WORKDIR}"
	cp VST2/* "${S}/build-scripts/native-modules/tuxguitar-synth-vst-linux-x86_64/include"
}

src_compile() {
	cd "${S}/build-scripts/tuxguitar-linux-swt-x86_64"
	mvn -e clean verify -s "${WORKDIR}"/.m2/settings.xml -P native-modules
	sed -i -e "s:Icon=.*:Icon=tuxguitar:" target/tuxguitar-SNAPSHOT-linux-swt-x86_64/share/applications/tuxguitar.desktop
	rm target/tuxguitar-SNAPSHOT-linux-swt-x86_64/doc/INSTALL.md
	rm target/tuxguitar-SNAPSHOT-linux-swt-x86_64//doc/LICENSE
	# set the hardcoded audio driver to the one the user want
	DRIVERF="target/tuxguitar-SNAPSHOT-linux-swt-x86_64/dist/tuxguitar-fluidsynth.cfg"
	if use fluidalsa; then sed -i -e "s:pulseaudio:alsa:" "${DRIVERF}"; fi
	if use fluidjack; then sed -i -e "s:pulseaudio:jack:" "${DRIVERF}"; fi
	if use fluidsdl; then sed -i -e "s:pulseaudio:sdl2:" "${DRIVERF}"; fi
	if use fluidoss; then sed -i -e "s:pulseaudio:oss:" "${DRIVERF}"; fi
	if use fluidpipewire; then sed -i -e "s:pulseaudio:pipewire:" "${DRIVERF}"; fi
	if use fluidportaudio; then sed -i -e "s:pulseaudio:portaudio:" "${DRIVERF}"; fi
	#pulseaudio is the hardcoded default
}

src_install() {
	cd "${S}/build-scripts/tuxguitar-linux-swt-x86_64/target/tuxguitar-SNAPSHOT-linux-swt-x86_64"
	insinto /usr/share/tuxguitar
	doins -r dist
	doins -r share/help
	doins -r share/lang
	doins -r lib
	doins -r lv2-client
	doins -r share/plugins
	doins -r share/scales
	doins -r share/skins
	# the replace-soundfont patch remove it, but TuxGuitar works
#	doins -r share/soundfont
	doins -r share/templates
	doins -r share/tunings
	doins -r vst-client
	insinto /usr/share
	doins -r share/applications
	doins -r share/man
	doins -r share/mime
	doins -r share/pixmaps
	insopts -m 755
	dobin "${FILESDIR}"/tuxguitar
	dodoc doc/*
	einstalldocs

	if use fluidsynth; then
		ewarn "Fluidsynth plugin blocks behavior of JSA plugin."
		ewarn "Enable only one of them in \"Tools > Plugins\""
		ewarn "Fuildsynth plugin is the only synth with a font"
		ewarn "preference dialog. For this feature,"
		ewarn "${P} must be merged with USE=\"fluidsynth\"."
	fi
}
