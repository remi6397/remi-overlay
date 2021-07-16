# SPDX-License-Identifier: MIT

EAPI=7

DESCRIPTION="Pidgin libpurple bridge to signald."
HOMEPAGE="https://github.com/hoehermann/libpurple-signald"
SRC_URI="https://github.com/hoehermann/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0-or-later"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	net-im/signald
	net-im/pidgin
"
RDEPEND="${DEPEND}"
BDEPEND=""
DOCS=( HOWTO.md )

src_prepare() {
	default
}

src_compile() {
	emake
}
