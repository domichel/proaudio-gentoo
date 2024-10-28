# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="SilentJack is a silence/dead air detector for the Jack Audio Connection Kit"
HOMEPAGE="http://www.aelius.com/njh/silentjack"
SRC_URI="http://www.aelius.com/njh/silentjack/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jack"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
