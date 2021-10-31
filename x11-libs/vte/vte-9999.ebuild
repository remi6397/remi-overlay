# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )
VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.32"

inherit meson python-any-r1 vala xdg git-r3

DESCRIPTION="Library providing a virtual terminal emulator widget"
HOMEPAGE="https://wiki.gnome.org/Apps/Terminal/VTE"

# Once SIXEL support ships (0.66 or later), might need xterm license (but code might be considered upgraded to LGPL-3+)
LICENSE="LGPL-3+ GPL-3+"
SLOT="2.91"
IUSE="+crypt debug gtk-doc +icu +introspection systemd +vala vanilla sixel"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~mips ppc ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
REQUIRED_USE="vala? ( introspection )"

EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"

RDEPEND="
	>=x11-libs/gtk+-3.24.22:3[introspection?]
	>=dev-libs/fribidi-1.0.0
	>=dev-libs/glib-2.52:2
	crypt?  ( >=net-libs/gnutls-3.2.7:0= )
	icu? ( dev-libs/icu:= )
	>=x11-libs/pango-1.22.0
	>=dev-libs/libpcre2-10.21
	systemd? ( >=sys-apps/systemd-220:= )
	sys-libs/zlib
	introspection? ( >=dev-libs/gobject-introspection-1.56:= )
	x11-libs/pango[introspection?]
"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	dev-libs/libxml2:2
	dev-util/glib-utils
	gtk-doc? ( >=dev-util/gtk-doc-1.13
		app-text/docbook-xml-dtd:4.1.2 )
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig

	vala? ( $(vala_depend) )
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.64.1-meson-Find-python-explicitly-to-honor-downstream-pyt.patch
)

src_prepare() {
	# -Ddebugg option enables various debug support via VTE_DEBUG, but also ggdb3; strip the latter
	sed -e '/ggdb3/d' -i meson.build || die

	use vala && vala_src_prepare
	xdg_src_prepare
}

src_configure() {
	local emesonargs=(
		-Da11y=true
		$(meson_use debug debugg)
		$(meson_use gtk-doc docs)
		$(meson_use introspection gir)
		-Dfribidi=true # pulled in by pango anyhow
		-Dglade=true
		$(meson_use crypt gnutls)
		-Dgtk3=true
		-Dgtk4=false
		$(meson_use icu)
		$(meson_use systemd _systemd)
		$(meson_use vala vapi)
		$(meson_use sixel)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	mv "${ED}"/etc/profile.d/vte{,-${SLOT}}.sh || die
}
