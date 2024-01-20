# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake
CMAKE_BUILD_TYPE="Release"

DESCRIPTION="A multi-effects board that is a merging of original rakarrak and its LV2 portage rkrlv2 with various enhancements"
HOMEPAGE="https://github.com/Stazed/rakarrack-plus"
SRC_URI="https://github.com/Stazed/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

# Use the default from CMakeLists.txt:
IUSE="+altivec -carlap -debug +lv2 +nsm +optimization +rplus +sse +sse2 -sysex +vectorize"

MDEPEND="dev-build/cmake
	>=media-libs/alsa-lib-0.9
	media-libs/fontconfig
	media-libs/libsamplerate
	media-libs/libsndfile
	media-libs/lv2
	>=media-sound/alsa-utils-0.9
	sci-libs/fftw:3.0
	sys-libs/zlib
	x11-libs/fltk:1
	x11-libs/libXft
	x11-libs/libXpm
	x11-libs/libXrender
	virtual/jack

	nsm? ( media-libs/liblo )"
BDEPEND="carlap? ( dev-lang/python )
	${MDEPEND}"
RDEPEND="!media-sound/rakarrack
	${MDEPEND}"
DEPEND="${MDEPEND}"

src_prepare() {
	default
	sed -i -e "s:share/doc/rakarrack-plus:share/doc/rakarrack-plus-${PV}:g" CMakeLists.txt || die "sed CMakeFileList.txt failed"
	sed -i -e "s:share/doc/rakarrack-plus:share/doc/rakarrack-plus-${PV}:g" doc/help/CMakeLists.txt || die "sed help CMakeFileList.txt failed"
	sed -i -e "s:share/doc/rakarrack-plus:share/doc/rakarrack-plus-${PV}:g" doc/help/css/CMakeLists.txt || die "sed css CMakeFileList.txt failed"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(if use altivec; then echo "-DEnableAltivec=ON"; else echo "-DEnableAltivec=OFF"; fi)
		$(if use carlap; then echo "-DBuildCarlaPresets=ON"; else echo "-DBuildCarlaPresets=OFF"; fi)
		$(if use debug; then echo "-DBuildForDebug=ON"; else echo "-DBuildForDebug=OFF"; fi)
		$(if use lv2; then echo "-DBuildLV2Plugins=ON -DLV2_INSTALL_DIR:PATH=lib64/lv2/RakarrackPlus.lv2"; else echo "-DBuildLV2Plugins=OFF"; fi)
		$(if use nsm; then echo "-DEnableNSM=ON"; else echo "-DEnableNSM=OFF"; fi)
		$(if use optimization; then echo "-DEnableOptimizations=ON"; else echo "-DEnableOptimizations=OFF"; fi)
		$(if use rplus; then echo "-DBuildRakarrackPlus=ON"; else echo "-DBuildRakarrackPlus=OFF"; fi)
		$(if use sse; then echo "-DEnableSSE=ON"; else echo "-DEnableSSE=OFF"; fi)
		$(if use sse2; then echo "-DEnableSSE2=ON"; else echo "-DEnableSSE2=OFF"; fi)
		$(if use sysex; then echo "-DEnableSysex=ON"; else echo "-DEnableSysex=OFF"; fi)
		$(if use vectorize; then echo "-DEnableVectorization=ON"; else echo "-DEnableVectorization=OFF"; fi)
	)
	cmake_src_configure
}
