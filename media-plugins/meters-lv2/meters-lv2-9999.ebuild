# Copyright 1999-2011 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop git-r3 multilib xdg-utils

DESCRIPTION="A colletion of audio level meters with GUI in LV2 plugin format"
HOMEPAGE="https://github.com/x42/meters.lv2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/x42/meters.lv2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/lv2
	x11-libs/pango
	x11-libs/cairo
	virtual/opengl
	x11-libs/gtk+:2"
RDEPEND=""

DOCS=( AUTHORS README.md )

src_prepare() {
	default
	make submodules
}

src_compile() {
	STRIP="echo" emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)/lv2" install
	einstalldocs
	insinto /usr/share/applications
	for i in "${FILESDIR}"/*.desktop; do
		doins "${i}"
	done
	insinto /usr/share/doc/"${P}"
	for i in doc/*.png; do
		doins "${i}"
	done
	newicon -s 256 img/x42-meters.png x42-meter.png
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
