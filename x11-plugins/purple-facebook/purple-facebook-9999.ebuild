# SPDX-License-Identifier: MIT

EAPI=7

inherit autotools git-r3

DESCRIPTION="Facebook protocol plugin for libpurple"
HOMEPAGE="https://github.com/dequis/purple-facebook"
EGIT_REPO_URI="https://github.com/dequis/purple-facebook.git"
HG_REPO_URI="https://keep.imfreedom.org/pidgin/pidgin"
HG_CHECKOUT_DIR="${S}/.pidgin"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/json-glib
	net-im/pidgin
"
DEPEND="${RDEPEND}"
BDEPEND=""

DOCS=( AUTHORS ChangeLog NEWS README VERSION )

# TODO:XXX: fix network-sandbox
RESTRICT=network-sandbox

src_prepare() {
	default
	./autogen.sh || die 1
}
