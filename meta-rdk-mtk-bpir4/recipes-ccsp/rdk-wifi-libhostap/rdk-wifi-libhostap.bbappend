FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_remove = " file://Rpi_rdkwifilibhostap_changes.patch"
SRC_URI_remove = " file://fixed_6G_wrong_freq.patch"
SRC_URI_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'HOSTAPD_2_10', 'file://2.10/wpa3_compatibility_hostap_2_10.patch', '', d)}"
SRC_URI_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'HOSTAPD_2_11', 'file://2.11/Bpi_rdkwifilibhostap_2_11_changes.patch', 'file://2.10/Bpi_rdkwifilibhostap_2_10_changes.patch', d)}"

CFLAGS_append = " -D_PLATFORM_BANANAPI_R4_"
