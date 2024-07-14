# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

[[ "${PV}" = "9999" ]] && inherit subversion
inherit autotools desktop

DESCRIPTION="Audio mixer for JACK with OSC control, LASH support and GTK GUI"
HOMEPAGE="http://sourceforge.net/projects/${PN}"

if [[ "${PV}" = 9999 ]]; then
	ESVN_REPO_URI="https://svn.code.sf.net/p/${PN}/code/trunk/"
	KEYWORDS=""
else
	MY_PV="${PV/_p/-r}"
	SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_PV}"
	KEYWORDS="~amd64 ~ppc ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DOCS=( AUTHORS ChangeLog README TODO )

RDEPEND="virtual/jack
	>=gnome-base/libgnomecanvas-2.30
	>=media-libs/liblo-0.25
	>=net-dns/libidn-1.13
	media-sound/lash
	=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}
	>=dev-libs/libxml2-2.6.28
	virtual/pkgconfig"

src_prepare() {
	default
	sed -i -e "s:0.4:${PV}:" configure.ac || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	doicon "doc/${PN}.svg"
	make_desktop_entry "${PN}_gtk" JackMixDesk "${PN}" "AudioVideo;Audio;Mixer"
}
