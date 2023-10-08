# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop git-r3 multilib xdg-utils

DESCRIPTION="MixTrix is a matrix mixer & trigger processor intended to be used with sisco-lv2"
HOMEPAGE="https://x42.github.io/mixtri.lv2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/x42/mixtri.lv2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/lv2
	media-libs/libltc
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/cairo
	virtual/opengl"
RDEPEND=""

DOCS=( README.md )

src_prepare() {
	default
	make submodules
}

src_compile() {
	STRIP="echo" emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)" install
	einstalldocs
	insinto /usr/share/applications
	doins "${FILESDIR}"/x42-mixtri.desktop
	insinto /usr/share/doc/"${P}"
	doins img/matrix_doc.png
	doins img/mixtri.png
	doins img/mixtrix.png
	doins img/trigger_modes3.png
	newicon -s 256 img/x42_mixtri.png x42-mixtri.png
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
