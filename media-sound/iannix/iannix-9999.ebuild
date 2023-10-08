# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils

DESCRIPTION="A Graphical Open-Source Sequencer For Digital Art"
HOMEPAGE="http://www.iannix.org/"
EGIT_REPO_URI="https://github.com/buzzinglight/IanniX.git"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="examples"

DEPEND="${RDEPEND}"
RDEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtscript
	dev-qt/qtsql
	dev-qt/qttest
	dev-qt/qtopengl
	dev-qt/qtsvg
	media-libs/freetype
	x11-libs/libSM
	x11-libs/libXrender
	media-libs/mesa
	media-libs/alsa-lib
	x11-libs/gdk-pixbuf"

DOCS=( Readme.md )
PATCHES=( "${FILESDIR}/${P}-fix_paths.patch" \
	  "${FILESDIR}/${P}-syntax_help.patch" \
	  "${FILESDIR}/desktop.patch" \
	  "${FILESDIR}/fix_spelling_errors.patch" )

src_configure() {
	eqmake5 PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT="${D}" PREFIX="/usr/" install

#	cd "${S}/Patches/Ableton Live/"
#	mv 'Icon'$'\r' Icon
#	cd "${S}"

	insinto /usr/lib/${PN}
	doins -r Patches
	doins -r Tools
	# It doesn't work anyway:
#	make_wrapper Iannix "/usr/bin/iannix" "/usr/share/${PN}" "/usr/share/${PN},/usr/share/${PN}/pixmaps"

	if use examples; then
		insinto /usr/share/${PN}
		doins -r Examples
	fi
}

pkg_postinst() {
	einfo "The installation script is a calimity,"
	einfo ""
	einfo "see https://github.com/buzzinglight/IanniX/issues"
	einfo ""
	einfo "for current issues."
	einfo ""

	if use examples; then
		einfo "The examples have been installed to /usr/share/${PN}/examples"
	fi
	einfo "The documentation is available by clicking on the ? button in IanniX"
}
