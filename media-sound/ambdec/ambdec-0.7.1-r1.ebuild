# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit exteutils toolchain-funcs multilib

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

src_prepare() {
	epatch "${FILESDIR}/${P}-Makefile.patch"
	eapply_user
}

src_compile() {
	tc-export CC CXX
	CFLAGS="$(pkg-config --cflags gthread-2.0) $CFLAGCS" \
	LDLIBS="$(pkg-config --libs gthread-2.0)" \
	emake PREFIX="/usr" LIBDIR="$(get_libdir)" || die "make failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die "install failed"
	cd ..
	dodoc AUTHORS README "$DISTDIR"/ambdec-manual.pdf
}
