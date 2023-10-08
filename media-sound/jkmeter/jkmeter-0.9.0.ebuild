# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="8"
inherit toolchain-funcs

DESCRIPTION="Jkmeter is a combined RMS/digital peak meter based on the ideas of mastering guru Bob Katz"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DEPEND="virtual/jack
	>=dev-libs/libclthreads-2.4.0
	>=x11-libs/libclxclient-3.6.1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/source

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix Makefile
	sed -i -e "s@\(^PREFIX.*\)@\PREFIX = /usr@g" \
		-e "s@\(/usr/bin/install[^\$]*\)@\1\$(DESTDIR)@g" Makefile || die "sed failed"
}

src_compile() {
	CXX="$(tc-getCXX)" emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ../AUTHORS ../README
}
