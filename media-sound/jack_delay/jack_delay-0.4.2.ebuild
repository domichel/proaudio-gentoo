# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="measures the latency between two jack ports with subsample accuracy"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/jack"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/source

RESTRICT="mirror"

src_compile() {
	CXX="$(tc-getCXX)" emake || die
}

src_install() {
	dobin jack_delay
	dodoc ../AUTHORS ../README
}
