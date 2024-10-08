# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs xdg

DESCRIPTION="A WYSIWYG LV2 GUI/Plugin creator tool"
HOMEPAGE="https://github.com/brummer10/XUiDesigner"
EGIT_REPO_URI="https://github.com/brummer10/XUiDesigner.git"
KEYWORDS=""

LICENSE="OBSD-1"
SLOT="0"

IUSE=""

DEPEND="app-editors/vim-core
	media-libs/lilv
	dev-libs/glib:2
	x11-libs/cairo
	x11-libs/libX11
"
RDEPEND="
	${DEPEND}
	dev-lang/python
"
BDEPEND="
	sys-devel/gettext
"

DOCS=( README.md README.developer.md )
PATCHES=( "${FILESDIR}"/libxputty-cflags.patch
	"${FILESDIR}"/desktop-database.patch )

src_compile() {
	#sed work fine but xuidesigner is still stripped...
	sed -i -e 's:--strip-all::g' -e '/STRIP/d' XUiDesigner/src/XUiGenerator.c || die "sed failed"
	emake QUIET="" AR=$(tc-getAR) LD=$(tc-getLD) CC=$(tc-getCC) -j1 INSTALL_DIR=/usr/lib64
}

src_install() {
	emake DESTDIR="${D}" INSTALL_DIR=/usr/lib64 -j1 install
	einstalldocs
}
