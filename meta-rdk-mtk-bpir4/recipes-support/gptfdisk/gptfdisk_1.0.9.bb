SUMMARY = "GPT fdisk (gdisk and sgdisk)"
DESCRIPTION = "GPT fdisk is a text-mode partitioning tool for GPT disks"
HOMEPAGE = "https://sourceforge.net/projects/gptfdisk/"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552"

SRC_URI = "https://downloads.sourceforge.net/project/gptfdisk/gptfdisk/${PV}/gptfdisk-${PV}.tar.gz"
SRC_URI[sha256sum] = "dafead2693faeb8e8b97832b23407f6ed5b3219bc1784f482dd855774e2d50c2"

S = "${WORKDIR}/gptfdisk-${PV}"

DEPENDS += "util-linux popt"

#inherit pkgconfig
inherit pkgconfig systemd

do_compile() {
    oe_runmake gdisk sgdisk
}

do_install:append() {
    install -d ${D}${bindir}
    install -Dm755 ${B}/gdisk ${D}${bindir}/gdisk
    install -Dm755 ${B}/sgdisk ${D}${bindir}/sgdisk
}

