# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 qmake-utils

DESCRIPTION="JMess can save/load an XML file with all the current jack connections"
HOMEPAGE="https://ccrma.stanford.edu/groups/soundwire/software/jmess/"
EGIT_REPO_URI="https://github.com/jacktrip/jmess-jack.git"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
IUSE="debug"

DEPEND="virtual/jack
	dev-qt/qtcore"
RDEPEND="${DEPEND}"

#S="${WORKDIR}/${P}/src"

DOCS=("${S}/${PN}/INSTALL.txt" "${S}/${PN}/TODO.txt")

src_compile() {
	cd ${PN}/src
	if use debug ; then
		echo -n ""
	else
		sed -i -e '/QMAKE_CXXFLAGS += -g -O2/d' jmess.pro
	fi
	eqmake5 QSPEC=linux-g++ jmess.pro
	make clean
	eqmake5 QSPEC=linux-g++ jmess.pro
	if use debug ; then
		make debug
	else
		make release
	fi
}

src_install() {
	cd ${PN}/src
	dobin jmess
	einstalldocs
}

