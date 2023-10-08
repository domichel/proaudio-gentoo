# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
inherit desktop toolchain-funcs xdg

DESCRIPTION="Simple waveform viewer for JACK"
HOMEPAGE="http://das.nasophon.de/jack_oscrolloscope/"
SRC_URI="http://das.nasophon.de/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jack
	media-libs/libsdl[sound,video]
	x11-libs/libX11
	virtual/opengl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="mirror"
PATCHES=( "${FILESDIR}"/${P}-Makefile.patch
	"${FILESDIR}"/${P}-linking.patch )

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake PREFIX="${EPREFIX}"/usr DESTDIR="${D}" install
	dodoc README NEWS
	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
	doicon -s 256 "${FILESDIR}"/${PN}.png
}
