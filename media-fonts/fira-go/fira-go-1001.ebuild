# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

MY_PN="FiraGO"
MY_PV="715cd3e8b59179822cd5b86933ecfc254cd1e74e"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Independent Open Source typeface"
HOMEPAGE="https://bboxtype.com/typefaces/FiraGO"
SRC_URI="https://github.com/bBoxType/FiraGO/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="+otf ttf"

REQUIRED_USE="|| ( otf ttf )"

S="${WORKDIR}/${MY_P}"

DOCS=( README.md OFL.txt Fonts/FiraGO_${PV}_CHANGE_LOG.rtf )

src_prepare() {
	default
}

src_install() {
	use otf && { FONT_S="${S}/Fonts/FiraGO_OTF_${PV}"; FONT_SUFFIX="otf"; }
	use ttf && { FONT_S="${S}/Fonts/FiraGO_TTF_${PV}"; FONT_SUFFIX="ttf"; }

	find "${FONT_S}" -type f -exec mv {} "${FONT_S}" \; || die 1

	font_src_install
	einstalldocs
}
