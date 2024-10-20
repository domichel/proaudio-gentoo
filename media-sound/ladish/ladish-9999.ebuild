# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
PYTHON_REQ_USE='threads(+)'

inherit flag-o-matic python-single-r1 waf-utils

DESCRIPTION="LADI Session Handler - a session management system for JACK applications"
HOMEPAGE="https://ladish.org"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LADI/ladish.git"
	EGIT_BRANCH="main"
#	EGIT_BRANCH="1-stable"
else
	SRC_URI="https://github.com/LADI/ladish/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

IUSE="debug doc lash"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="media-libs/alsa-lib
	media-sound/jack2[dbus]
	sys-apps/dbus
	dev-libs/cdbus
	dev-libs/expat
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/intltool
	virtual/pkgconfig

	doc? ( app-doc/doxygen )
"

QA_SONAME=( ".*/libalsapid.so" )

src_prepare()
{
	rm -rf ".git" || die "Failed to remove git dir"
	sed -i -e "s/RELEASE = False/RELEASE = True/" wscript
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
	python_fix_shebang "${ED}"
}

pkg_preinst() {
	rm "${ED}/usr/share/ladish/COPYING" || die "rm COPYING failed"
}
