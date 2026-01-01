# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..14} )
PYTHON_REQ_USE='threads(+)'

inherit flag-o-matic python-single-r1 waf-utils

DESCRIPTION="LADI Session Handler - a session management system for JACK applications"
HOMEPAGE="https://ladish.org"
SRC_URI="https://dl.ladish.org/ladish/ladish-1.3-gfcd24852.tar.bz2"
S="${WORKDIR}/${PN}-1.3-gfcd24852"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc lash"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="mirror"

RDEPEND="media-libs/alsa-lib
	>=media-sound/jack2[dbus]
	sys-apps/dbus
	dev-libs/expat
	lash? ( media-sound/lash )
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )
	>=media-sound/jack2-2.21.0
	virtual/pkgconfig"

DOCS=( AUTHORS README.adoc NEWS )

PATCHES=(
)

src_prepare()
{
	append-cxxflags '-std=c++11'
	default
}

src_configure() {
	local -a mywafconfargs=(
		--distnodeps
		$(usex debug --debug '')
		$(usex doc --doxygen '')
		$(usex lash '--enable-liblash' '')
	)
	waf-utils_src_configure "${mywafconfargs[@]}"
}

src_install() {
	use doc && HTML_DOCS="${S}/build/default/html/*"
	waf-utils_src_install
}
