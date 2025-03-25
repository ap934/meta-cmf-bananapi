FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_remove = " file://Rpi_rdkwifilibhostap_changes.patch"
SRC_URI_remove = " file://fixed_6G_wrong_freq.patch"
SRC_URI_append = " file://Bpi_rdkwifilibhostap_changes.patch "

CFLAGS_append = " -D_PLATFORM_BANANAPI_R4_"
