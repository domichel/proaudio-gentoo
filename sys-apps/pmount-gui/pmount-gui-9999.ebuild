# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="git://git.tdb.fi/pmount-gui"

inherit git-r3 toolchain-funcs

DESCRIPTION="A simple graphical frontend for pmount"
HOMEPAGE="http://git.tdb.fi/?p=pmount-gui:a=summary"
SRC_URI=""
LICENSE="Mikkosoft"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/udev
	sys-apps/pmount
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	# Respect CFLAGS and LDFLAGS
	sed -i -e 's:-Wall -Wextra:${CFLAGS} ${LDFLAGS}:' Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin pmount-gui
	dodoc README.txt
}
