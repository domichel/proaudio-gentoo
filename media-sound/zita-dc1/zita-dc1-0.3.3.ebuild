# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop toolchain-funcs

DESCRIPTION="Dynamics compressor"
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

PATCHES=("${FILESDIR}/${P}_Makefile.patch")

src_compile() {
	emake CXX="$(tc-getCXX)" PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
	newicon ../share/redzita.png zita-dc1.png
	make_desktop_entry zita-dc1 'zita-Dynamic Compressor 1' zita-dc1 'AudioVideo;Audio;Engineering;'
}
