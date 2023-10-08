# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 multilib

DESCRIPTION="convoLV2 is a lv2 plugin to convolve audio signals"
HOMEPAGE="http://github.com/x42/convoLV2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/x42/convoLV2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/lv2
	media-libs/zita-convolver
	media-libs/libsndfile
	media-libs/libsndfile
	x11-libs/gtk+:2"
RDEPEND=""

DOCS=( README.md )

src_configure() {
	echo "Nothing to configure"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="$(get_libdir)" LV2DIR="/usr/$(get_libdir)/lv2" install
	dodoc "${DOCS}"
}
