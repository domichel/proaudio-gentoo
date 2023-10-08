# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="a simple mixer for the Jack Audio Connection Kit with an OSC based
control interface"
HOMEPAGE="http://www.aelius.com/njh/jackminimix"
SRC_URI="http://www.aelius.com/njh/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="virtual/jack
	>=media-libs/liblo-0.23"

DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README AUTHORS TODO ChangeLog
}
