# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RESTRICT="mirror"
IUSE=""
DESCRIPTION="YC-20 divide-down combo organ emulator with lv2 plugin"
HOMEPAGE="https://github.com/sampov2/foo-yc20/"
SRC_URI="https://github.com/sampov2/foo-yc20/archive/refs/tags/1.3.0.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/cairo
	dev-cpp/gtkmm:2.4
	virtual/jack
	media-libs/lv2
	>=dev-lang/faust-0.9.58"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX="/usr"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
