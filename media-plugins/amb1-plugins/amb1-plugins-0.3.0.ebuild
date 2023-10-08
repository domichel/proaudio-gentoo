# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_P="${P/amb/AMB}"

DESCRIPTION="AMB-plugins ladspa plugin package. Filters by Fons Adriaensen"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="media-libs/ladspa-sdk"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-Makefile.patch
)

DOCS=( AUTHORS README )

src_prepare() {
	default
	echo libdir = $(get_libdir)
#	sed -e "s:/usr/lib/ladspa:\$(DESTDIR)/\$(PREFIX)/$(get_libdir)/ladspa:" -i source/Makefile
}

src_compile() {
	cd source
	emake CXX="$(tc-getCXX)"
}

src_install() {
	insinto /usr/$(get_libdir)/ladspa
	insopts "-m755"
	doins source/*.so
	einstalldocs
}
