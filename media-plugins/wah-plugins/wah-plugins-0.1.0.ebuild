# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit multilib toolchain-funcs

RESTRICT="mirror"
MY_P="${P/wah/WAH}"

DESCRIPTION="Auto-WAH plugin."
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/ladspa/index.html"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/ladspa-sdk"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default
	cd "${S}"
	# fixup the Makefile
	sed -i -e 's@g++@\$(CXX) \$(LDFLAGS)@g' -e '/^CXXFLAGS/ s/-O3//' Makefile
}

src_compile() {
	tc-export CXX
	emake || die
}

src_install() {
	dodoc AUTHORS README
	insinto /usr/$(get_libdir)/ladspa
	insopts -m0755
	doins *.so
}
