FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PACKAGES =+ " \
    ${PN}-bcm-bt \
    ${PN}-brcm \
    ${PN}-rtl-bt \
"

FILES:${PN}-bcm-bt = " \
    ${nonarch_base_libdir}/firmware/brcm/BCM* \
"

FILES:${PN}-brcm = " \
    ${nonarch_base_libdir}/firmware/brcm/* \
"

FILES:${PN}-rtl-bt = " \
    ${nonarch_base_libdir}/firmware/rtl_bt/* \
"

# Override meta-filogic's wrong subdir path — files are flat in mediatek/
FILES:${PN}-mt7988 = " \
    ${nonarch_base_libdir}/firmware/mediatek/mt7988* \
"

RDEPENDS:${PN}-bcm-bt += "${PN}-brcm"
ALLOW_EMPTY:${PN} = "1" 

do_install:append() {
    find ${D}${nonarch_base_libdir}/firmware -mindepth 1 -maxdepth 1 \
        ! -name 'brcm' ! -name 'rtl_bt' ! -name 'airoha' ! -name 'mediatek' \
        ! -name 'LICENSE*' ! -name 'LICENCE*' ! -name 'WHENCE' \
        -exec rm -rf {} +

    rm -rf ${D}${nonarch_base_libdir}/firmware/mediatek/mt7996
    rm -rf ${D}${nonarch_base_libdir}/firmware/mediatek/mt7988
    rm -rf ${D}${nonarch_base_libdir}/firmware/mediatek/mt7996/mt7996*
}

RRECOMMENDS:${PN} = " \
    ${PN}-bcm-bt \
    ${PN}-brcm \
    ${PN}-rtl-bt \
    ${PN}-airoha \
    ${PN}-mt7988 \
"
