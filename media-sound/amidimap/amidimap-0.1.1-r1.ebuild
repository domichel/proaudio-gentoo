# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Read in, process and output MIDI events."
HOMEPAGE="https://cowlark.com/amidimap/index.html"
SRC_URI="https://cowlark.com/amidimap/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/alsa-lib-0.9"

RESTRICT="mirror"

DOCS=( README psr300.map )

PATCHES=( "${FILESDIR}"/${P}-Makefile.patch )

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin amidimap
	dodoc "${DOCS[@]}"
}
