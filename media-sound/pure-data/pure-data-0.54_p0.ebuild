# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop libtool xdg

MY_P="pd-${PV/_p/-}"

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://msp.ucsd.edu/software.html"
SRC_URI="http://msp.ucsd.edu/Software/${MY_P}.src.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"

KEYWORDS="~amd64"

IUSE="+alsa debug experimental extra +fftw instance jack libpd portaudio utils +watchdog"
#portmidi is not working

RDEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	jack? ( virtual/jack )
	fftw? ( >=sci-libs/fftw-3 )
	portaudio? ( media-libs/portaudio )"
#portmidi is not working
#	portmidi? ( media-libs/portmidi )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	local myconfargs
	if use experimental ; then
		myconfargs="--with-floatsize=64"
	else
		myconfargs=""
	fi
	econf $(use_enable alsa) \
		$(use_enable debug) \
		$(use_enable extra libpd-extra) \
		$(use_enable fftw)  \
		$(use_enable instance libpd-instance) \
		$(use_enable jack) \
		$(use_enable libpd) \
		$(use_enable portaudio) \
		$(use_enable utils libpd-utils) \
		$(use_enable watchdog) \
		--disable-oss \
		"${myconfargs}"
#portmidi is not working
}

src_install() {
	default
	if use watchdog; then dosym "/usr/$(get_libdir)/pd/bin/pd-watchdog" "/usr/bin/pd-watchdog"; fi
}

pkg_preinst() {
	sed -i -e "s/Categories=Audio;AudioVideo;Development;Music;Graphics/Categories=AudioVideo;AudioVideoEditing;/" \
		"${ED}"/usr/share/applications/org.puredata.pd-gui.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
