# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 multilib

DESCRIPTION="Stereo DJ X-fade"
HOMEPAGE="http://github.com/x42/xfade.lv2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/x42/xfade.lv2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/lv2"
RDEPEND=""

DOCS=( README.md )

src_prepare() {
	default
	sed -i -e 's:$(STRIP):#:' Makefile || die "sed failed"
}

src_configure() {
	echo "Nothing to configure"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)/lv2" install
	einstalldocs
}
