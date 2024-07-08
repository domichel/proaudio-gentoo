# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs multilib

DESCRIPTION="A command line JACK app generating white and pink gaussian noise"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="https://github.com/domichel/proaudio-gentoo/blob/main/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/jack"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/source
RESTRICT="mirror"
PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_compile() {
	CXX="$(tc-getCXX)" emake PREFIX="/usr" LIBDIR="$(get_libdir)" || die
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die
	cd ..
	dodoc AUTHORS README
}
