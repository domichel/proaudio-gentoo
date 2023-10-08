# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop toolchain-funcs

DESCRIPTION="Loudness measurement according to EBU-R128"
HOMEPAGE="https://kokkinizita.linuxaudio.org/linuxaudio"
SRC_URI="https://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libclthreads-2.4.0
	>=x11-libs/libclxclient-3.9
	media-libs/libpng
	media-libs/libsndfile
	virtual/jack"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/source
RESTRICT="mirror"

DOCS=(../AUTHORS ../README ../doc/loudness-meter-pres.pdf
	  ../doc/loudness-meter.pdf)
HTML_DOCS=(../doc/)

PATCHES=("${FILESDIR}"/${P}-Makefile.patch)

src_compile() {
	emake PREFIX="${EPREFIX}/usr" CXX="$(tc-getCXX)" 
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	make_desktop_entry ${PN} ${PN} "" "AudioVideo;Audio;"
}
