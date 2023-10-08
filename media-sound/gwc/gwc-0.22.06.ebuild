# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

IUSE="alsa pulseaudio singlefft"

inherit xdg
RESTRICT="mirror"
DESCRIPTION="Gnome Wave Cleaner"
HOMEPAGE="http://gwc.sourceforge.net/"
MY_P="gtk-wave-cleaner-0.22-06"
SRC_URI="https://downloads.sourceforge.net/project/gwc/gwc2/0.22-6/${MY_P}.tar.gz"
#sourceforge.net/projects/gwc/files/gwc2/0.22-6/gtk-wave-cleaner-0.22-06.tar.gz

SLOT="0"
LICENSE="GPL-1"
KEYWORDS="amd64 ~ppc x86"

DEPEND=">=media-libs/libsndfile-1.0.1
	virtual/pkgconfig
	=sci-libs/fftw-3*
	x11-libs/gtk+:2
	alsa? ( >=media-libs/alsa-lib-0.9 )
	pulseaudio? ( media-sound/pulseaudio )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	eapply_user
	sed -i -e /gtk-update-icon-cache/d Makefile.in
}

src_configure() {
	econf $(use_enable alsa) $(use_enable pulseaudio pa) \
		$(use_enable singlefft single-fftw3) || die "Configuration failed"
	# Build the meschach math library first
	# so good CFLAGS are used
	cd ${S}/meschach
	PATH=".:$PATH"
	econf --with-sparse || die "Failed to configure meschach math-lib"
}

src_compile() {
	cd ${S}/meschach
	( make part1 && make part2 && make part3 && cp machine.h ..) || die \
	            "Failed to compile meschach math-lib"

	# Now build gwc
	cd ${S}
	PATH=.:${PATH}
	emake || die
}
