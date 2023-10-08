# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils toolchain-funcs multilib

DESCRIPTION="A command line JACK app generating white and pink gaussian noise"
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

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
	eapply_user
}

src_compile() {
	CXX="$(tc-getCXX)" emake PREFIX="/usr" LIBDIR="$(get_libdir)" || die
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die
	cd ..
	dodoc AUTHORS README
}
