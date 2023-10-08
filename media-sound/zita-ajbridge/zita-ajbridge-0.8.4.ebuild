# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Bridge ALSA devices to Jack clients, to provide additional capture (a2j) or playback (j2a) channels"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/alsa-lib
	>=media-libs/zita-alsa-pcmi-0.3.0
	>=media-libs/zita-resampler-1.6.0
	virtual/jack"

S=${WORKDIR}/${P}/source
RESTRICT="mirror"

DOCS=( ../AUTHORS ../README )

PATCHES=("${FILESDIR}"/${P}-Makefile.patch)

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
