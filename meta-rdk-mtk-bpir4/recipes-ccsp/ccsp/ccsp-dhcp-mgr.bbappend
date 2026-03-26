include ccsp_common_bananapi.inc
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
 
SRC_URI += "file://dhcp_manager_mapt.patch"

CFLAGS_append  = " ${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_wan_manager', '-DFEATURE_RDKB_WAN_MANAGER', '', d)}"
