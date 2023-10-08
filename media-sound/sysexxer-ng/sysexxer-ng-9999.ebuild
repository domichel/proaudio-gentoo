# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="Universal tool to exchange MIDI system-exclusive data"
HOMEPAGE="https://github.com/linuxmao-org/sysexxer-ng"
EGIT_REPO_URI="https://github.com/linuxmao-org/sysexxer-ng.git"

LICENSE="BOOST-1.0"
SLOT="0"
IUSE=""

DEPEND=">=dev-util/cmake-3.3
	>=media-libs/alsa-lib-1.0.9
	sys-devel/gettext
	x11-libs/fltk:1
	virtual/jack"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	cmake_src_prepare
	sed -i -e "s:AudioVideo;Audio:AudioVideo;Audio;Engineering;:" "${S}"/resources/application/sysexxer-ng.desktop
}
