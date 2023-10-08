# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Yet Another Time Machine: simple command line audio player which
can perform time-stretched playback"
HOMEPAGE="https://github.com/mlang/yatm"
SRC_URI="https://github.com/mlang/yatm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="media-libs/libao
	media-libs/libmad
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libsoundtouch
	media-libs/speex
	sys-libs/slang"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="mirror"

DOCS=( ChangeLog README )
