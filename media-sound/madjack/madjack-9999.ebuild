# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
inherit autotools desktop git-r3 libtool qmake-utils xdg

DESCRIPTION="MadJACK is a MPEG Audio Deck for the Jack Audio Connection Kit with an OSC based control interface"
HOMEPAGE="https://www.aelius.com/njh/madjack/"
EGIT_REPO_URI="https://github.com/njh/madjack.git"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
IUSE="qt5"

DEPEND="qt5? ( dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5 )
	>=media-libs/liblo-0.23
	>=media-libs/libmad-0.15
	virtual/jack
	virtual/pkgconfig"

DOCS=( README AUTHORS TODO ChangeLog )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	if use qt5 ; then
		QTDIR=/usr/$(get_libdir)/qt5 econf
	else
		econf
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	einstalldocs
	if use qt5 ; then
		dobin gui/qmadjack
		make_desktop_entry qmadjack QMadJack "" "AudioVideo;Audio;Player"
	fi
}
