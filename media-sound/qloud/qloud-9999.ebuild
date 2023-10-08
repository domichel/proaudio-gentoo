# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 multilib

DESCRIPTION="Tool to measure loudspeaker frequency and step responses and distortions"
HOMEPAGE="http://gaydenko.com/qloud/ https://github.com/molke-productions/qloud"
EGIT_REPO_URI="https://github.com/molke-productions/qloud"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-qt/qtcharts:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtxml:5
	dev-qt/qtxmlpatterns:5
	dev-qt/qtwidgets:5
	virtual/jack
	>=media-libs/libsndfile-1.0
	>=sci-libs/fftw-3.0"

src_prepare() {
	eapply_user
	sed -i -e "s/AudioVideo;Audio;/AudioVideo;Audio;Engineering;/" qloud.desktop
}

src_compile() {
	/usr/bin/qmake5 PREFIX="/usr"
	emake || die "Compilation failed"
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
