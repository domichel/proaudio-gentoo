# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tool for storing/restoring jack connections states."
HOMEPAGE="http://sourceforge.net/projects/heaven/"
SRC_URI="mirror://sourceforge/heaven/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="virtual/jack"
RDEPEND="$DEPEND"

PREFIX="${D}"/usr

DOCS=( README TODO )

src_prepare() {
	eapply_user
	sed -i -e 's/$(CXX)/$(CXX) $(CXXFLAGS)/' -e '/^install:/ a\
	mkdir -p $(PREFIX)/bin' Makefile || die "sed Makefile failed"
}

#src_compile() {
#	emake jack_snapshot || die "emake failed"
#}

src_install() {
	emake PREFIX="${PREFIX}" install || die "stop"
	einstalldocs
}
