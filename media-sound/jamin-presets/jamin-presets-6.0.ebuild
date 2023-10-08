# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of presets for Jamin made by Gilberto Andre Borges"
HOMEPAGE="https://musical-artifacts.com/artifacts?formats=deb&q=Gilberto+Andr%C3%A9+Borges+%28Gilblack%29&tags=preset"
SRC_URI="https://github.com/domichel/GenCool/raw/master/distfiles/${P}.tar.bz2"

LICENSE="CC-BY-4.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-sound/jamin"

S=${WORKDIR}/usr/share/jamin/presets
RESTRICT="mirror"

src_install() {
	insinto /usr/share/jamin/presets
	dodoc 1_SOBREPRESETS
	rm 1_SOBREPRESETS
	doins *
}
