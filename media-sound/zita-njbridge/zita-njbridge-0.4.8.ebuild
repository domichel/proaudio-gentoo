# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Jack client to transmit full quality mutlichannel audio over IP local network"
HOMEPAGE="https://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="https://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/alsa-lib
	>=media-libs/zita-resampler-1.6.0
	virtual/jack"

S=${WORKDIR}/${P}/source
RESTRICT="mirror"

DOCS=( ../AUTHORS ../README )

PATCHES=( "${FILESDIR}"/${P}-Makefile.patch
	"${FILESDIR}"/${P}_manpages.patch )

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
