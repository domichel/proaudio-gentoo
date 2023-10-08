# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Zita-rev1 is a reworked version of the reverb originally developed for Aeolus"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"
#SRC_URI="http://download.tuxfamily.org/proaudio/distfiles/${P}.tar.bz2"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libclthreads-2.4.0
	>=x11-libs/libclxclient-3.6.1
	virtual/jack"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/source"

PATCHES=("${FILESDIR}/${P}-makefile.patch")
DOCS=( ../AUTHORS ../README )
HTML_DOCS=( ../doc )

src_compile() {
	CXX="$(tc-getCXX)" emake PREFIX=/usr || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die
	einstalldocs
}
