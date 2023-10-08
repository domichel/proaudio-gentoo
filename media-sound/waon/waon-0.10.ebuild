# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="A wave to notes transcriber, able to transcribe wav to midi"
HOMEPAGE="http://waon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk pv"

OCDEPEND="media-libs/libao
	media-libs/libsamplerate"
RDEPEND="media-libs/libsndfile
	sci-libs/fftw:3.0
	pv? ( ${OCDEPEND} )
	gtk? ( x11-libs/gtk+:2
		   ${OCDEPEND} )"
DEPEND="${RDEPEND}
	!media-sound/waonc
	virtual/pkgconfig"

RESTRICT="mirror"

DOCS=( ChangeLog README TIPS TODO )

src_prepare() {
	default
	sed -i -e "s/-O3//" Makefile || die
}

src_compile() {
	tc-export CC
	emake waon
	use pv && emake pv
	use gtk && emake gwaon
}

src_install() {
	# no make install in makefile
	dobin waon
	doman waon.1

	if use pv; then
		dobin pv
		doman pv.1
	fi

	if use gtk; then
		dobin gwaon
		doman gwaon.1
	fi

	dodoc "${DOCS[@]}"
}
