# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

IUSE="doc examples"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Faust AUdio STreams is a programming language/compiler for fast DSP algorythms."
HOMEPAGE="http://faudiostream.sourceforge.net"
SRC_URI="https://github.com/grame-cncm/${PN}/archive/v0-9-90.zip -> ${P}.zip"
S="${WORKDIR}/${PN}-0-9-90"

RDEPEND="sys-devel/bison
	sys-devel/flex"
DEPEND="sys-apps/sed
	doc? ( app-doc/doxygen )"

src_compile() {
	PREFIX=/usr emake
	if use doc ; then
		make doc
	fi
}

src_install() {
	emake install PREFIX=/usr DESTDIR="${D}"
	dodoc README
	if use doc ; then
	    dodoc WHATSNEW documentation/*.pdf "documentation/additional documentation" \
		    documentation/touchOSC.txt
	    dohtml dox/html/*.html dox/html/*.png dox/html/*.css dox/html/*.js
	fi
	if use examples ; then
	    insinto /usr/share/"${P}"/examples
	    doins examples/*
	fi
}
