# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop git-r3 multilib xdg-utils

DESCRIPTION="A musical instrument tuner with strobe characteristic in LV2 plugin formt"
HOMEPAGE="https://github.com/x42/tuna.lv2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/x42/tuna.lv2.git"

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

DOCS=( README.md img/tuna1.png img/tuna2.png )

src_prepare() {
	default
	sed -i -e 's:$(STRIP):#$(STRIP):' Makefile
	sed -i '/$(STRIP)/d' robtk/robtk.mk
	make submodules
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)" install
	einstalldocs
	doicon -s 256 img/x42-tuna.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/x42-tuna.desktop
	doins "${FILESDIR}"/x42-tuna-spectrum.desktop
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
