# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Analog style vocoder inspiredby the EMS vocoders"
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
	x11-libs/cairo
	media-libs/libpng
	x11-libs/libXft
	x11-libs/libX11
	virtual/jack"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/source"

PATCHES=("${FILESDIR}/${P}-makefile.patch")
DOCS=( ../AUTHORS ../README )
#HTML_DOCS=( ../doc )

src_compile() {
	CXX="$(tc-getCXX)" emake PREFIX=/usr || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die
	einstalldocs
}
