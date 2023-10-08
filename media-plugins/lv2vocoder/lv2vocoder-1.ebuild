# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib

IUSE=""
DESCRIPTION="An lv2 vocoder plugin"
HOMEPAGE="http://gna.org/projects/lv2vocoder"
SRC_URI="http://cdn-fastly.deb.debian.org/debian/pool/main/l/lv2vocoder/lv2vocoder_1.orig.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
SLOT="0"

DEPEND=""

PATCHES=( "${FILESDIR}"/0001-fix_symbols.patch \
	"${FILESDIR}"/0002-pass_flags.patch \
	"${FILESDIR}"/1000-FR_translation.patch )

DOCS=( README lv2vocoder-ingen.png lv2vocoder-patchage.png )

src_install() {
	dodir /usr/$(get_libdir)/lv2
	LV2_PATH="${D}/usr/$(get_libdir)/lv2" emake DESTDIR="${D}" install || die "Install failed"
	einstalldocs
}
