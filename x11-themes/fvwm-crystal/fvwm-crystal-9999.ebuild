# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
RESTRICT=mirror

PYTHON_COMPAT=( python3_{8..13} )
inherit readme.gentoo-r1 python-single-r1

DESCRIPTION="Configurable FVWM theme with transparency and freedesktop compatible menu"
HOMEPAGE="http://fvwm-crystal.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
FVWM_DEPEND=">=x11-wm/fvwm-2.6.9[png]"

case ${PV} in
*9999)
	PROPERTIES="live"
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	EGIT_BRANCH="main"
	SRC_URI=""
	KEYWORDS=""
#	S="${WORKDIR}/${PN}"
	src_unpack() {
		git-r3_src_unpack
	};;
esac

RDEPEND="${PYTHON_DEPS}
	acct-group/fvwm-crystal
	|| ( >=x11-wm/fvwm3-3.1.0.4[go] >=x11-wm/fvwm-2.6.9[png] )
	virtual/imagemagick-tools
	|| ( >=x11-misc/stalonetray-0.6.2-r2 x11-misc/trayer )
	|| ( x11-misc/hsetroot media-gfx/feh )
	sys-apps/sed
	sys-devel/bc
	app-alternatives/awk
	x11-apps/xwd
	media-sound/alsa-utils"
DEPEND="${RDEPEND}"

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="After installation, execute the following commands:
	$ cp -r "${EROOT}"/usr/share/doc/"${PF}"/addons/Xresources ~/.Xresources
	$ cp -r "${EROOT}"/usr/share/doc/"${PF}"/addons/Xsession ~/.xinitrc

Many applications can extend functionality of fvwm-crystal.
They are listed in "${EROOT}"/usr/share/doc/"${PF}"/INSTALL.*

To be able to use the exit menu, each user using ${PN}
must be in the group fvwm-crystal.
You can do that as root with:
	$ useradd -G fvwm-crystal <user_name>
and log out and in again.
"

src_install() {
	emake 	DESTDIR="${ED}" \
		docdir="${EPREFIX}/usr/share/doc/${PF}" \
		prefix="${EPREFIX}/usr" \
		install
	# GNU License is globally in the portage tree
	rm -vf "${ED}/usr/share/doc/${PF}"/LICENSE

	python_doscript "${ED}/usr/bin/${PN}".{apps,wallpaper}
	python_scriptinto "/usr/share/${PN}"/fvwm/scripts/FvwmMPD
	python_doscript "${ED}/usr/share/${PN}"/fvwm/scripts/FvwmMPD/*.py
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
	elog "Many applications can extend functionality of fvwm-crystal."
	elog "They are listed in ${EROOT}usr/share/doc/${PF}/INSTALL.bz2"
	elog "Popular supported softwares are:"
	elog "- x11-misc/xdg-user-dirs (the gtk USE is not needed) to"
	elog "  get localized XDG user directories support"
	elog "- sys-power/pm-utils or sys-apps/systemd for hibernate/resume support"
	elog "- media-sound/jack-audio-connection-kit for a professional sound server"
	elog "- several media players"
}
