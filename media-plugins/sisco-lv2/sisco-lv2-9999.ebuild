# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop git-r3 multilib xdg-utils

DESCRIPTION="Simple LV2 audio oscilloscope"
HOMEPAGE="http://x42.github.io/sisco.lv2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/x42/sisco.lv2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/lv2
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/cairo
	virtual/opengl"
RDEPEND=""

DOCS=( README.md img/scopeVSwave.png img/sisco1.png img/sisco2.png img/sisco4.png )

src_prepare() {
	default
	sed -i '/$(STRIP)/d' Makefile || die "sed failed"
	sed -i '/$(STRIP)/d' robtk/robtk.mk || die "sed failed"
}

src_compile() {
	emake submodules
	emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)/lv2" install
	einstalldocs
	insinto /usr/share/applications
	doins "${FILESDIR}"/x42-scope.desktop
	doicon -s 256 img/x42-scope.png
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
