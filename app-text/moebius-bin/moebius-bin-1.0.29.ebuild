# SPDX-License-Identifier: GPL-2.0-only

EAPI=7

inherit unpacker xdg-utils

MY_PN="Moebius"

DESCRIPTION="Modern ANSI & ASCII Art Editor"
HOMEPAGE="https://blocktronics.github.io/moebius/"
SRC_URI="https://github.com/blocktronics/moebius/releases/download/${PV}/Moebius.deb"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

S="${WORKDIR}"
QA_PREBUILT="
	opt/Moebius/*.so
	opt/Moebius/moebius
	opt/Moebius/chrome-sandbox
"

RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
"

src_install() {
	insinto /opt
	doins -r opt/${MY_PN}
	fperms 755 /opt/${MY_PN}/moebius
	fperms 4755 /opt/${MY_PN}/chrome-sandbox

	insinto /usr/share/applications
	doins usr/share/applications/moebius.desktop

	insinto /usr/share/icons
	doins -r usr/share/icons/hicolor
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
