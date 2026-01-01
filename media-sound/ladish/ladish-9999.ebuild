# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..14} )
PYTHON_REQ_USE='threads(+)'

inherit flag-o-matic python-single-r1 waf-utils xdg-utils

DESCRIPTION="LADI Session Handler - a session management system for JACK applications"
HOMEPAGE="https://ladish.org"
inherit git-r3
EGIT_REPO_URI="https://github.com/LADI/ladish"
EGIT_BRANCH="1-stable"
EGIT_COMMIT=7728d2d40e1c8eeb84b8605a411d9a83701d48b3
EGIT_SUBMODULES=()
LICENSE="GPL-2"

SLOT="0"
KEYWORDS=""

IUSE="debug doc lash gtk"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="mirror"

RDEPEND="media-libs/alsa-lib
	media-sound/jack2[dbus]
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

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
