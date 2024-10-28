# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="a simple mixer for the Jack Audio Connection Kit with an OSC based
control interface"
HOMEPAGE="http://www.aelius.com/njh/jackminimix/"
EGIT_REPO_URI="http://github.com/njh/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/jack
	>=media-libs/liblo-0.23"

DEPEND="${RDEPEND}"

src_prepare(){
	eapply_user
	"${S}/autogen.sh" || die
}

src_install(){
	make DESTDIR="${D}" install || die "install failed"
	dodoc README.md AUTHORS ChangeLog
}
