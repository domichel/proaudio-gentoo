# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
PYTHON_REQ_USE="threads(+)"
inherit git-r3 multilib python-any-r1 waf-utils

MY_P=triceratops-${PV}-dpf-August-2023
DESCRIPTION="Triceratops is a polyphonic subtractive synthesizer plugin for use with the LV2 architecture"
HOMEPAGE="http://sourceforge.net/projects/triceratops/"
EGIT_REPO_URI="https://github.com/thunderox/triceratops.git"

LICENSE="CCPL-Attribution-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/lv2"
DEPEND="${PYTHON_DEPS}
	${RDEPEND}
	>=dev-cpp/cairomm-1.0
	>=dev-cpp/gtkmm-2.4"

DOCS=( README.md )

src_prepare() {
	default
	sed -i -e "s:/usr/lib/lv2:/usr/$(get_libdir)/lv2:" wscript
}
