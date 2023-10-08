# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
inherit autotools desktop git-r3

DESCRIPTION="Multi-deck media playback for radio stations"
HOMEPAGE="https://github.com/adiknoth/4deckradio"
EGIT_REPO_URI="https://github.com/adiknoth/${PN}.git"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="-old"

RDEPEND="x11-libs/gtk+:3
	old? ( media-libs/gstreamer:0.10 )
	!old? ( media-libs/gstreamer:1.0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	old? ( media-plugins/gst-plugins-jack:0.10 )
	!old? ( media-plugins/gst-plugins-jack:1.0 )"

AUTOTOOLS_AUTORECONF="1"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=( $(use_with old old-gstreamer) )
	econf ${myeconfargs}
}

src_install() {
	emake DESTDIR="${D}" install
	make_desktop_entry "${PN}" "${PN}" "multimedia-player" "AudioVideo;Audio;Player"
}
