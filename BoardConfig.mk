#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/veux

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
BUILD_WITHOUT_VENDOR := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a55

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := veux


# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_SEPARATED_DTBO := true
VENDOR_CMDLINE := androidboot.hardware=qcom \
lpm_levels.sleep_disabled=1 \
service_locator.enable=1 \
androidboot.usbcontroller=4e00000.dwc3 \
swiotlb=noforce \
loop.max_part=7 \
iptable_raw.raw_before_defrag=1 \
ip6table_raw.raw_before_defrag=1 \
firmware_class.path=/vendor/firmware
BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb $(OUT_DIR)/target/product/veux/obj/KERNEL_OBJ/arch/arm64/boot/dts/vendor/qcom/blair.dtb
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline "$(VENDOR_CMDLINE)"

BOARD_RAMDISK_USE_LZ4 := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true

TARGET_KERNEL_CONFIG := veux_defconfig
TARGET_KERNEL_SOURCE := kernel/xiaomi/sm6375
TARGET_KERNEL_NO_GCC := true

# Partitions
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_USES_METADATA_PARTITION := true

BOARD_VEUX_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor
BOARD_VEUX_DYNAMIC_PARTITIONS_SIZE := 9122611200 # BOARD_SUPER_PARTITION_SIZE - 4MB
BOARD_SUPER_PARTITION_GROUPS := veux_dynamic_partitions

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_VENDOR := vendor
# Platform
BOARD_USES_QCOM_HARDWARE := true
BOARD_VENDOR := xiaomi
TARGET_BOARD_PLATFORM := holi

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Recovery
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_F2FS := true

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# TWRP specific build flags
## General
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
TW_HAS_EDL_MODE := true
TW_BATTERY_SYSFS_WAIT_SECONDS := 5
TW_INCLUDE_FASTBOOTD := 1

TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

## CPU
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone26/temp"

TARGET_RECOVERY_QCOM_RTC_FIX := true

## Crypto & FBE
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2

BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true

## Display
TW_FRAMERATE := 120
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 200

## Filesystem
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_NO_EXFAT_FUSE := true
TW_IS_SUPER := 1

RECOVERY_SDCARD_ON_DATA := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

## Misc.
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

# end of TWRP

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_VBMETA_SYSTEM := product system system_ext
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
