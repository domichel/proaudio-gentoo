# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake git-r3 xdg

RESTRICT="mirror"
DESCRIPTION="The Linux (midi) MUSic Editor (a sequencer)"
HOMEPAGE="https://github.com/muse-sequencer/muse"
EGIT_REPO_URI="https://github.com/muse-sequencer/muse.git"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64"
IUSE="debug doc dssi fluidsynth lash lrdf lv2 osc python rtaudio rubberband vst"
REQUIRED_USE=""

	# TODO: libinstpatch not in gentoo
CDEPEND=">=media-libs/alsa-lib-1.1.3
	>=media-libs/libsamplerate-0.1.9
	>=media-libs/libsndfile-1.0.28
	media-libs/ladspa-sdk
	virtual/jack
	>=kde-frameworks/extra-cmake-modules-5.94.0
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dssi? ( >=media-libs/dssi-0.9.0 )
	lash? ( >=media-sound/lash-0.4.0 )
	lrdf? ( >=media-libs/liblrdf-0.5.0 )
	lv2? ( >=media-libs/lv2-1.14.0
		>=dev-libs/sord-0.16.0
		>=media-libs/lilv-0.24.0
		dev-cpp/gtkmm
		x11-libs/gtk+ )
	osc? ( >=media-libs/liblo-0.23 )
	python? ( dev-python/Pyro4
		dev-python/PyQt5 )
	rtaudio? ( >=media-libs/rtaudio-5.0 )
	rubberband? ( media-libs/rubberband )
	vst? ( media-plugins/dssi-vst )"
RDEPEND="${CDEPEND}
	fluidsynth? ( >=media-sound/fluidsynth-1.1.9 )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-text/openjade
		   app-doc/doxygen
		   media-gfx/graphviz )"

S="${WORKDIR}/${P}/src"

PATCHES=("${FILESDIR}"/${P}-cmake-rpath.patch)
# get ride of the -g flag
CMAKE_BUILD_TYPE="release"

src_configure() {
	if use debug ; then
		CMAKE_BUILD_TYPE="debug"
	fi
	# fix the doc PATH
	sed -i -e 's:^SET(MusE_INSTALL_NAME  "muse-4.2"):SET(MusE_INSTALL_NAME  "museseq-9999"):' CMakeLists.txt || die "sed doc path failed"
	# the Category key is uterly complicated, fix it
	sed -i -e 's/Categories=Sequencer;Midi;X-Jack;X-Sequencers;X-MIDI;Audio;AudioVideo;/Categories=AudioVideo;Audio;Sequencer;/' \
		packaging/io.github.muse_sequencer.Muse.desktop.in || die "sed Categories key failed"
	local mycmakeargs=(
		-DENABLE_INSTPATCH="off"
		-DENABLE_DSSI="$(usex dssi)"
		-DENABLE_FLUID="$(usex fluidsynth)"
		-DENABLE_LASH="$(usex lash)"
		-DENABLE_LRDF="$(usex lrdf)"
		-DENABLE_LV2="$(usex lv2)"
		-DENABLE_LV2_GTK2="$(usex lv2)"
		-DENABLE_OSC="$(usex osc)"
		-DENABLE_PYTHON="$(usex python)"
		-DENABLE_RTAUDIO="$(usex rtaudio)"
		-DENABLE_RUBBERBAND="$(usex rubberband)"
		-DENABLE_VST_NATIVE="$(usex vst)"
	)
	cmake_src_configure
}

pkg_preinst() {
	rm "${ED}/usr/share/doc/${P}/COPYING.bz2" || die "rm COPYING failed"
	rm "${ED}/usr/share/doc/${P}/simpledrums/COPYING" || die "rm simpledrums COPYING failed"
	rm "${ED}/usr/share/doc/${P}/vam/COPYING.bz2" || die "rm vam COPYING failed"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
