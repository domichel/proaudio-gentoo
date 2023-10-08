# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit toolchain-funcs

DESCRIPTION="Yet Another Scrolling Scope features jack input, variable scrolling speed and automatic gain control"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/libclthreads-2.2.1
	>=x11-libs/libclxclient-3.3.1
	virtual/jack"
RDEPEND="${RDEPEND}"

src_compile() {
	tc-export CXX
	cd "${S}"/source
	emake PREFIX="${EPREFIX}/usr" || die "emake failed"
}

src_install() {
	cd "${S}"/source
	make DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install || die "make install failed"
	cd "${S}"
	dodoc AUTHORS README .yassrc
	ewarn "You must copy the .yassrc file in /usr/share/doc/${P}"
	ewarn "into your home directory before running ${PN}"
}
