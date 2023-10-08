# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A simple command line effect processor using LV2 plugins"
HOMEPAGE="http://naspro.sourceforge.net/"
SRC_URI="mirror://sourceforge/naspro/naspro/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsndfile
	media-libs/lilv"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="mirror"

DOCS=(AUTHORS ChangeLog NEWS README THANKS)
