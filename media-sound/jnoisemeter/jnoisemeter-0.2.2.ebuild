# Copyright 1921-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Jnoisemeter is a small app designed to measure audio test signals and in particular noise signals"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libclthreads-2.4.0
	>=x11-libs/libclxclient-3.9
	virtual/jack"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/source"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_compile() {
	tc-export CXX
	emake PREFIX=/usr || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" PREFIX=/usr install || die "make install failed"
	cd ..
	dodoc AUTHORS README
}
