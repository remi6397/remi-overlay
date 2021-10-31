EAPI=8

inherit cmake

DESCRIPTION="The Mir compositor"
HOMEPAGE="https://mir-server.io/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MirServer/mir.git"
else
	SRC_URI="https://github.com/MirServer/mir/archive/refs/tags/v2.5.0.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="|| ( GPL-2 GPL-3 ) || ( LGPL-2 LGPL-3 )"
SLOT="0"
IUSE="doc +lto pch test valgrind X wayland eglstream gbm"
REQUIRED_USE="|| ( X wayland eglstream gbm )"

RDEPEND="
	dev-libs/capnproto
	dev-cpp/gflags
	media-libs/glm
	dev-cpp/glog
	dev-util/lttng-ust
	media-libs/mesa
	dev-util/systemtap
	valgrind? ( dev-util/valgrind )
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
"

src_configure() {
	local mir_platform
	use X && mir_platform+="x11;"
	use wayland && mir_platform+="wayland;"
	use eglstream && mir_platform+="eglstream-kms;"
	use gbm && mir_platform+="gbm-kms;"
	mir_platform="${mir_platform%;}"

	local mycmakeargs=(
		-DMIR_ENABLE_TESTS=$(usex test)
		-DMIR_LINK_TIME_OPTIMIZATION=$(usex lto)
		-DMIR_USE_PRECOMPILED_HEADERS=$(usex pch)
		-DENABLE_MEMCHECK_OPTION=$(usex valgrind)
		-DMIR_PLATFORM=${mir_platform}
	)
	cmake_src_configure
}
