# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs multilib

RESTRICT="mirror"
DESCRIPTION="An Ambisonic decoder for first and second order"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2
	http://kokkinizita.linuxaudio.org/linuxaudio/downloads/ambdec-manual.pdf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/jack
	>=dev-libs/libclthreads-2.4.0
	>=x11-libs/libclxclient-3.6.1"

S="${S}/source"
RDEPEND="$DEPEND"
PATCHES=( "${FILESDIR}/${P}-Makefile.patch" )

src_compile() {
	tc-export CC CXX
	CFLAGS="$(pkg-config --cflags gthread-2.0) $CFLAGCS" \
	LDLIBS="$(pkg-config --libs gthread-2.0)" \
	emake PREFIX="/usr" LIBDIR="$(get_libdir)"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	cd .. || die "cd failed"
	dodoc AUTHORS README "$DISTDIR"/ambdec-manual.pdf
}
