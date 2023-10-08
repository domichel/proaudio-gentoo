# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 multilib

DESCRIPTION="LV2 plugins to filter MIDI events"
HOMEPAGE="http://github.com/x42/midifilter.lv2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/x42/midifilter.lv2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/lv2"
RDEPEND=""

DOCS=( AUTHORS README.md )

src_prepare() {
	default
	sed -i -e 's:$(STRIP):#$(STRIP):' Makefile || sed failed
}

src_configure() {
	echo "Nothing to configure"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)/lv2" install
	dodoc "${DOCS[@]}"
}
