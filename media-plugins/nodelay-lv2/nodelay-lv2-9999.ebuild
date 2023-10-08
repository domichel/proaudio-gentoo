# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 multilib

DESCRIPTION="LV2 audio delay line with latency reporting"
HOMEPAGE="http://github.com/x42/nodelay.lv2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/x42/nodelay.lv2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/lv2"
RDEPEND=""

DOCS=( README )

src_prepare() {
	default
	sed -i -e 's:$(STRIP):#$(STRIP):' Makefile
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)/lv2" install
	dodoc "${DOCS}"
}
