# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit

DESCRIPTION="From circuit to lv2 plugin"
HOMEPAGE="https://guitarix.org/"
SRC_URI="https://github.com/domichel/proaudio-gentoo/raw/refs/heads/main/distfiles/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="app-containers/docker
	app-shells/bash
	dev-vcs/git
"

src_install() {
		insinto /usr/share/"${PN}"
		doins Dockerfile python_venv
		exeinto /usr/share/"${PN}"
		doexe add_* docker-dkbuilder
		into /usr
		dobin "${FILESDIR}/dkbuilder"
		elog "dkbuilder is a script and associated files that let You install the dkbuilder"
		elog "docker environment into the directory of your choice."
		elog "Just run 'dkbuilder' and it will show You what to do."
		elog ""
		elog "For advice and support, check https://linuxmusicians.com/viewtopic.php?f=44&t=19586"
		elog "The exact URL on linux musicians can change, so search for dkbuilder"
		elog "The subject name is 'dkbuilder: from circuit to LV2 plugin'"
}
