# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Big Styles for the Calf Audio Plugins"
HOMEPAGE="https://github.com/domichel/calf_big_styles"
SRC_URI="https://github.com/domichel/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND="media-plugins/caps-plugins"

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" LICENSEINST=no install
}
