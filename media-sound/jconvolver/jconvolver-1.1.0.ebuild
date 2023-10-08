# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Command line convolution reverb by Fons Adriaensen"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/index.html"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2
	examples? ( http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${PN}-reverbs.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RESTRICT="mirror"

DEPEND=">=dev-libs/libclthreads-2.4.0
	>=media-libs/libsndfile-1.0.17
	>=media-libs/zita-convolver-4.0.0
	virtual/jack
	>=sci-libs/fftw-3.2.2:3.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/source

DOCS=(../AUTHORS ../README ../README.CONFIG)

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	if use examples; then
		insinto /usr/share/${PN}/examples
		docompress -x /usr/share/doc/${PN}/examples
		doins -r "${WORKDIR}"/reverbs/*
		doins -r "${WORKDIR}/${P}"/config-files/*
	fi
}
