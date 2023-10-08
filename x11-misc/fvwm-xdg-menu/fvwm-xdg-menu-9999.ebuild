# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3 xdg

EGIT_REPO_URI="https://github.com/domichel/fvwm-xdg-menu.git"

DESCRIPTION="xdg menu for use with fvwm and fvwm-menu-desktop"
HOMEPAGE="https://github.com/domichel/fvwm-xdg-menu"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

DOCS=( README.md )

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	einstalldocs
}
