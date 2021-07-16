# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )
DISTUTILS_SINGLE_IMPL="true"
DISTUTILS_USE_SETUPTOOLS="no"
inherit desktop distutils-r1 gnome2-utils xdg-utils

DESCRIPTION="A simple music browser for MPD"
HOMEPAGE="https://github.com/SoongNoonien/${PN}"
SRC_URI=""

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/SoongNoonien/${PN}.git"
else
	SRC_URI="https://github.com/SoongNoonien/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"

BDEPEND="dev-python/python-distutils-extra
"

RDEPEND="dev-libs/gobject-introspection:=
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_MULTI_USEDEP}]
		dev-python/python-mpd[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/beautifulsoup:4[${PYTHON_MULTI_USEDEP}]
	')
"

src_install() {
	distutils-r1_src_install

	rm -r "${D}"/usr/share/doc || die
	dodoc README.md AUTHORS NEWS
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}

