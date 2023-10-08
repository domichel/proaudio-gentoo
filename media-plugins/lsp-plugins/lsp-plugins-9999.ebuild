# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit flag-o-matic git-r3 xdg-utils

DESCRIPTION="Linux Studio Plugins Project"
HOMEPAGE="https://lsp-plug.in/"
EGIT_REPO_URI="https://github.com/sadko4u/lsp-plugins.git"
SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc jack ladspa +lv2 test vst X"
REQUIRED_USE="|| ( jack ladspa lv2 )"

RESTRICT="!test? ( test )"

BDEPEND="doc? ( dev-lang/php:* )"
DEPEND="!media-libs/lsp-plugins
	!media-plugins/lsp-plugins-lv2
	media-libs/libglvnd[X]
	media-libs/libsndfile
	jack? (
		media-libs/freetype
		virtual/jack
		x11-libs/cairo[X]
		x11-libs/libX11
		x11-libs/libXrandr
	)
	ladspa? ( media-libs/ladspa-sdk )
	lv2? (
		media-libs/freetype
		media-libs/lv2
		x11-libs/cairo[X]
		x11-libs/libX11
		x11-libs/libXrandr
	)
	vst? (
		media-libs/freetype
		x11-libs/cairo[X]
		x11-libs/libX11
		x11-libs/libXrandr
	)
"

RDEPEND="${DEPEND}"

DOCS="README.md"

src_unpack() {
	git-r3_fetch
	git-r3_checkout
	git-r3_fetch https://github.com/lsp-plugins/lsp-3rd-party.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-3rd-party.git "${WORKDIR}/${P}/modules/lsp-3rd-party"
	git-r3_fetch https://github.com/lsp-plugins/lsp-common-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-common-lib.git "${WORKDIR}/${P}/modules/lsp-common-lib"
	git-r3_fetch https://github.com/lsp-plugins/lsp-dsp-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-dsp-lib.git "${WORKDIR}/${P}/modules/lsp-dsp-lib"
	git-r3_fetch https://github.com/lsp-plugins/lsp-dsp-units.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-dsp-units.git "${WORKDIR}/${P}/modules/lsp-dsp-units"
	git-r3_fetch https://github.com/lsp-plugins/lsp-lltl-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-lltl-lib.git "${WORKDIR}/${P}/modules/lsp-lltl-lib"
	git-r3_fetch https://github.com/lsp-plugins/lsp-r3d-base-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-r3d-base-lib.git "${WORKDIR}/${P}/modules/lsp-r3d-base-lib"
	git-r3_fetch https://github.com/lsp-plugins/lsp-r3d-iface.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-r3d-iface.git "${WORKDIR}/${P}/modules/lsp-r3d-iface"
	git-r3_fetch https://github.com/lsp-plugins/lsp-r3d-glx-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-r3d-glx-lib.git "${WORKDIR}/${P}/modules/lsp-r3d-glx-lib"
	git-r3_fetch https://github.com/lsp-plugins/lsp-r3d-wgl-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-r3d-wgl-lib.git "${WORKDIR}/${P}/modules/lsp-r3d-wgl-lib"
	git-r3_fetch https://github.com/lsp-plugins/lsp-runtime-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-runtime-lib.git "${WORKDIR}/${P}/modules/lsp-runtime-lib"
	git-r3_fetch https://github.com/lsp-plugins/lsp-test-fw.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-test-fw.git "${WORKDIR}/${P}/modules/lsp-test-fw"
	git-r3_fetch https://github.com/lsp-plugins/lsp-tk-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-tk-lib.git "${WORKDIR}/${P}/modules/lsp-tk-lib"
	git-r3_fetch https://github.com/lsp-plugins/lsp-ws-lib.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-ws-lib.git "${WORKDIR}/${P}/modules/lsp-ws-lib"
	# module dependencies
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugin-fw.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugin-fw.git "${WORKDIR}/${P}/modules/lsp-plugin-fw"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-shared.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-shared.git "${WORKDIR}/${P}/modules/lsp-plugins-shared"
	# modules
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-ab-tester.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-ab-tester.git "${WORKDIR}/${P}/modules/lsp-plugins-ab-tester"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-art-delay.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-art-delay.git "${WORKDIR}/${P}/modules/lsp-plugins-art-delay"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-beat-breather.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-beat-breather.git "${WORKDIR}/${P}/modules/lsp-plugins-beat-breather"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-comp-delay.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-comp-delay.git "${WORKDIR}/${P}/modules/lsp-plugins-comp-delay"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-compressor.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-compressor.git "${WORKDIR}/${P}/modules/lsp-plugins-compressor"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-crossover.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-crossover.git "${WORKDIR}/${P}/modules/lsp-plugins-crossover"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-dyna-processor.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-dyna-processor.git "${WORKDIR}/${P}/modules/lsp-plugins-dyna-processor"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-expander.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-expander.git "${WORKDIR}/${P}/modules/lsp-plugins-expander"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-filter.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-filter.git "${WORKDIR}/${P}/modules/lsp-plugins-filter"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-flanger.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-flanger.git "${WORKDIR}/${P}/modules/lsp-plugins-flanger"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-gate.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-gate.git "${WORKDIR}/${P}/modules/lsp-plugins-gate"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-gott-compressor.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-gott-compressor.git "${WORKDIR}/${P}/modules/lsp-plugins-gott-compressor"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-graph-equalizer.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-graph-equalizer.git "${WORKDIR}/${P}/modules/lsp-plugins-graph-equalizer"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-impulse-responses.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-impulse-responses.git "${WORKDIR}/${P}/modules/lsp-plugins-impulse-responses"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-impulse-reverb.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-impulse-reverb.git "${WORKDIR}/${P}/modules/lsp-plugins-impulse-reverb"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-latency-meter.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-latency-meter.git "${WORKDIR}/${P}/modules/lsp-plugins-latency-meter"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-limiter.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-limiter.git "${WORKDIR}/${P}/modules/lsp-plugins-limiter"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-loud-comp.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-loud-comp.git "${WORKDIR}/${P}/modules/lsp-plugins-loud-comp"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-mb-compressor.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-mb-compressor.git "${WORKDIR}/${P}/modules/lsp-plugins-mb-compressor"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-mb-dyna-processor.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-mb-dyna-processor.git "${WORKDIR}/${P}/modules/lsp-plugins-mb-dyna-processor"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-mb-expander.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-mb-expander.git "${WORKDIR}/${P}/modules/lsp-plugins-mb-expander"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-mb-gate.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-mb-gate.git "${WORKDIR}/${P}/modules/lsp-plugins-mb-gate"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-mb-limiter.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-mb-limiter.git "${WORKDIR}/${P}/modules/lsp-plugins-mb-limiter"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-mixer.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-mixer.git "${WORKDIR}/${P}/modules/lsp-plugins-mixer"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-noise-generator.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-noise-generator.git "${WORKDIR}/${P}/modules/lsp-plugins-noise-generator"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-oscillator.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-oscillator.git "${WORKDIR}/${P}/modules/lsp-plugins-oscillator"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-oscilloscope.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-oscilloscope.git "${WORKDIR}/${P}/modules/lsp-plugins-oscilloscope"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-para-equalizer.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-para-equalizer.git "${WORKDIR}/${P}/modules/lsp-plugins-para-equalizer"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-phase-detector.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-phase-detector.git "${WORKDIR}/${P}/modules/lsp-plugins-phase-detector"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-profiler.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-profiler.git "${WORKDIR}/${P}/modules/lsp-plugins-profiler"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-room-builder.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-room-builder.git "${WORKDIR}/${P}/modules/lsp-plugins-room-builder"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-sampler.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-sampler.git "${WORKDIR}/${P}/modules/lsp-plugins-sampler"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-slap-delay.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-slap-delay.git "${WORKDIR}/${P}/modules/lsp-plugins-slap-delay"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-spectrum-analyzer.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-spectrum-analyzer.git "${WORKDIR}/${P}/modules/lsp-plugins-spectrum-analyzer"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-surge-filter.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-surge-filter.git "${WORKDIR}/${P}/modules/lsp-plugins-surge-filter"
	git-r3_fetch https://github.com/lsp-plugins/lsp-plugins-trigger.git
	git-r3_checkout https://github.com/lsp-plugins/lsp-plugins-trigger.git "${WORKDIR}/${P}/modules/lsp-plugins-trigger"
}

src_configure() {
	use doc && MODULES+="doc"
	use jack && MODULES+=" jack"
	use ladspa && MODULES+=" ladspa"
	use lv2 && MODULES+=" lv2"
	use vst && MODULES+=" vst2"
	use X && MODULES+=" xdg"
	emake \
		FEATURES="${MODULES}" \
		PREFIX="/usr" \
		LIBDIR="/usr/$(get_libdir)" \
		CFLAGS_EXT="${CFLAGS}" \
		CXXFLAGS_EXT="${CFLAGS}" \
		LDFLAGS_EXT="$(raw-ldflags)" \
		VERBOSE=1 \
		config
}

src_compile() {
	emake \
		FEATURES="${MODULES}" \
		PREFIX="/usr" \
		LIBDIR="/usr/$(get_libdir)" \
		CFLAGS_EXT="${CFLAGS}" \
		CXXFLAGS_EXT="${CFLAGS}" \
		LDFLAGS_EXT="$(raw-ldflags)" \
		VERBOSE=1
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${ED}" LIB_PATH="/usr/$(get_libdir)" VERBOSE=1 install
	einstalldocs
	if use doc; then
		einfo "We move the html doccumentation in its final path..."
		mkdir "${ED}/usr/share/doc/${P}"/html || die "mkdir failed"
		mv "${ED}/usr/share/doc/${PN}"/* "${ED}/usr/share/doc/${P}"/html || "mv doc failed"
	fi
}

pkg_preinst() {
	# We want the X-LSP... category to appear into a registered Main Category.
	cd "${D}"/usr/share/applications/ || die "cd failed"
	sed -i \
	-e 's:Categories=X-LSP-Plugins;:Categories=AudioVideo;Audio;X-LSP-Plugins;:' * || die "sed failed"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
