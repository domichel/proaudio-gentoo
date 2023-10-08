# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

DESCRIPTION="A basic console based DPM (Digital Peak Meter) for JACK"
HOMEPAGE="http://www.aelius.com/njh/jackmeter"
SRC_URI="http://www.aelius.com/njh/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jack"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="mirror"

DOCS=(AUTHORS README TODO)
