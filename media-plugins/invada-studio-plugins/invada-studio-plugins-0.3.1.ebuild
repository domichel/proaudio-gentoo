# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

#Thanks to ssuominen for his assistance with the creation of this ebuild
EAPI=8
inherit toolchain-funcs multilib

DESCRIPTION="Invada ladspa: Compressor, Filters, Reverb, Input Processor, Tube Simulator"
HOMEPAGE="https://launchpad.net/invada-studio/ladspa"
SRC_URI="https://launchpad.net/invada-studio/ladspa/0.3/+download/${PN}_${PV}-1.tar.gz"
LICENSE="GPL-2"

SLOT=0
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/ladspa-sdk-1.13"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/0.3.1-ladspa.patch )

src_prepare() {
	eapply -- "${PATCHES[@]}"
	# multilib-strict workaround
	sed -i -e "s|/lib/|/$(get_libdir)/|" Makefile || die
	eapply_user
}

src_compile() {
	tc-export AR CC
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CREDITS README
}
