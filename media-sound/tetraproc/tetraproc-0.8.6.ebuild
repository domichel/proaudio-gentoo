# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit toolchain-funcs

DESCRIPTION="A-format to B-format signal converter for tetrahedral Ambisonic
microphones"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/jack
	>=dev-libs/libclthreads-2.4.0
	>=x11-libs/libclxclient-3.9
	>=media-libs/libsndfile-1.0.23
	>=sci-libs/fftw-3.2.2:3.0"
RDEPEND="${DEPEND}"

S=${S}/source

RESTRICT="mirror"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )
DOCS=( ../AUTHORS ../README ../doc/blockdiagram.pdf )

src_compile() {
	LDFLAGS="$(pkg-config --libs gthread-2.0) $LDFLAGS" \
	CXX="$(tc-getCXX)" emake PREFIX="/usr" LIBDIR="$(get_libdir)" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die
	einstalldocs
#	cd ..
#	dodoc AUTHORS README doc/blockdiagram.pdf
}
