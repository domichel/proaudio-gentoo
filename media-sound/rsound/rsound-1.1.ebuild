# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Networked audio system to transfer audio data to a different computer."
HOMEPAGE="https://github.com/Themaister/RSound/"
SRC_URI="https://github.com/Themaister/RSound/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+alsa alsamod ao jack +libsamplerate openal oss portaudio pulseaudio vlcmod" # muroar roar syslog

S="${WORKDIR}/RSound-${PV}"

RDEPEND="alsa? ( media-libs/alsa-lib )
	alsamod? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	jack? ( virtual/jack )
	libsamplerate? ( media-libs/libsamplerate )
	openal? ( media-libs/openal )
	oss? ( media-libs/alsa-oss )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	vlcmod? ( media-video/vlc )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog DOCUMENTATION README"
PATCHES=( "${FILESDIR}/${P}_lib-path.patch" )

src_configure() {
	./configure \
		--prefix=/usr \
		--disable-muroar \
		--disable-roar \
		--enable-syslog \
		$(use_enable alsa) \
		$(use_enable ao libao) \
		$(use_enable jack) \
		$(use_enable openal) \
		$(use_enable oss) \
		$(use_enable portaudio) \
		$(use_enable pulseaudio pulse) \
		$(use_enable libsamplerate samplerate) || die "configure failed"
}

src_compile() {
	emake
	if use alsamod ; then
		cd patches/alsa
		emake
		cd "${S}"
	fi
	if use vlcmod ; then
		cd patches/alsa
		emake
		cd "${S}"
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs
	if use alsamod ; then
		cd patches/alsa
		emake DESTDIR="${D}" install
		cd "${S}"
	fi
	if use vlcmod ; then
		cd patches/alsa
		emake DESTDIR="${D}" install
		cd "${S}"
	fi
}
