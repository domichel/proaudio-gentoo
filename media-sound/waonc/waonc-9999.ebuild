# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop git-r3 autotools libtool xdg
#toolchain-funcs

DESCRIPTION="A wave to notes transcriber, able to transcribe wav to midi"
HOMEPAGE="http://waon.sourceforge.net/ https://github.com/ahlstromcj/waonc"
EGIT_REPO_URI="https://github.com/ahlstromcj/${PN}.git"

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
	!media-sound/waon
	virtual/pkgconfig"

RESTRICT="mirror"

DOCS=( README.md TODO doc/notes.txt doc/waon-quick-reference.pdf test-files )

src_prepare() {
	default
	./bootstrap
	autoupdate
#	eautoreconf
	sed -i -e "s/-O3//g" configure || die
}

src_configure() {
#	echo "Nothing to do"
	./configure --prefix=/usr --libdir=/usr/$(get_libdir)
}

src_compile() {
#	tc-export CC
#	econf
	emake || die
	#waon
#	use pv && emake pv
#	use gtk && emake gwaon
}

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs
	newman man/waon.1 waonc.1
	newman man/pv.1 pvc.1
	newman man/gwaon.1 gwaonc.1
	make_desktop_entry waonc waonc "" "AudioVideo;Audio;Midi"
	doicon -s 256 "${FILESDIR}"/gwaonc.png
}
