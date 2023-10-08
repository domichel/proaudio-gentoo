# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Look-ahead digital peak level limiter"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libclthreads-2.4.0
	>=x11-libs/libclxclient-3.9.0
	>=media-libs/zita-resampler-1.1.0
	virtual/jack
	>=sci-libs/fftw-3.2.2:3.0"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/source"
RESTRICT="mirror"

DOCS=( ../AUTHORS )
HTML_DOCS=( ../doc/ )

PATCHES=("${FILESDIR}/${P}_Makefile.patch")

src_compile() {
	emake CXX="$(tc-getCXX)" PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
