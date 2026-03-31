include ccsp_common_bananapi.inc

CFLAGS_append  = " ${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_wan_manager', '-DFEATURE_RDKB_WAN_MANAGER', '', d)}"
CFLAGS_append  += " ${@bb.utils.contains('DISTRO_FEATURES', 'dhcp_manager', '-DFEATURE_RDKB_DHCP_MANAGER', '', d)}"

FILESEXTRAPATHS_append := "${THISDIR}/files:"
SRC_URI:append = " file://0001-RDKBDEV-3401-RDKBACCL-1526-RNDIS-interface-is-not-wo.patch"
