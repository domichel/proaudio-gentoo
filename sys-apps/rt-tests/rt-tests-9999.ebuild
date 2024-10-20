# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..14} )

inherit git-r3

DESCRIPTION="Programs to test various rt-linux features."
HOMEPAGE="http://git.kermel.org/cgit/linux/kernel/git/clrkwllms"
EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/${PN}.git"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="sys-process/numactl"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( README.markdown )
PATCHES=( "${FILESDIR}/${P}_man-fix.patch" )

src_install() {
	emake DESTDIR="${D}" prefix="/usr" install
	einstalldocs
}
