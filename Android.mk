#
# Copyright (C) 2024-2026 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),devonf)

include $(CLEAR_VARS)
LOCAL_MODULE := kernel-headers
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE):
	@mkdir -p $(dir $@)
	@cp -a $(LOCAL_PATH)/kernel-headers/* $(dir $@)/
	@touch $@

endif
