# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit autotools

DESCRIPTION="Industrializer is a program for generating percussion sounds for musical purposes"
HOMEPAGE="http://sourceforge.net/projects/industrializer"
SRC_URI="mirror://sourceforge/industrializer/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa jack -pulse"

RDEPEND=">=dev-libs/libxml2-2.6
	media-libs/audiofile
	>=x11-libs/gtk+-2.0
	>=x11-libs/gtkglext-1.2
	virtual/opengl
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

RESTRICT="mirror"

DOCS=( AUTHORS ChangeLog NEWS README.md TODO )

PATCHES=( "${FILESDIR}/${P}-Makefile.patch"
	"${FILESDIR}/${P}-desktop.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable alsa) \
		$(use_enable jack) \
		$(use_enable pulse)
}
