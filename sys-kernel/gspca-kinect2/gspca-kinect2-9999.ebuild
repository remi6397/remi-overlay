# SPDX-License-Identifier: MIT

EAPI=7

inherit git-r3 linux-mod

DESCRIPTION="Kinect2 Sensor Device Driver for Linux"
HOMEPAGE="https://github.com/grandchild/gspca-kinect2"
EGIT_REPO_URI="https://github.com/grandchild/gspca-kinect2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=("${FILESDIR}"/${PN}-Makefile.patch)

CONFIG_CHECK="!USB_GSPCA"
BUILD_TARGETS="clean modules"
MODULE_NAMES="
	gspca_main(usb)
	gspca_kinect2(usb)
"
