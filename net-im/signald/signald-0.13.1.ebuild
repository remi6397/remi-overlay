# SPDX-License-Identifier: MIT

EAPI=7

DESCRIPTION="unofficial daemon for interacting with Signal"
HOMEPAGE="https://signald.org/"
SRC_URI="https://gitlab.com/signald/${PN}/-/archive/${PV}/signald-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0-or-later"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/gradle"
RDEPEND="
	|| ( virtual/jre virtual/jdk )
"

src_prepare() {
	default
}

src_compile() {
	emake installDist
}
