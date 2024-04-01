LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= sqlite3

ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
  LOCAL_CFLAGS := -fPIC -O2 -fno-strict-aliasing -march=armv8-a
  LOCAL_ARM_NEON := true
endif
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  LOCAL_CFLAGS := -fPIC -O2 -fno-strict-aliasing -mfloat-abi=softfp -march=armv7-a
  LOCAL_ARM_MODE := arm
  LOCAL_ARM_NEON := true
endif
ifeq ($(TARGET_ARCH_ABI),armeabi)
  LOCAL_CFLAGS := -fPIC -Os -fno-strict-aliasing -mfloat-abi=softfp -mfpu=vfp -march=armv5te
  LOCAL_ARM_MODE := thumb
endif
ifeq ($(TARGET_ARCH),x86_64)
  LOCAL_CFLAGS := -fPIC -O2 -fno-strict-aliasing -malign-double -march=x86-64 -msse4.2 -mpopcnt -fno-stack-protector
endif
ifeq ($(TARGET_ARCH),x86)
  LOCAL_CFLAGS := -fPIC -O2 -fno-strict-aliasing -malign-double -march=i686 -mssse3 -mfpmath=sse -fno-stack-protector
endif

LOCAL_SRC_FILES:= sqlite3.c

LOCAL_CFLAGS += -DSQLITE_THREADSAFE=2 -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_FTS5

include $(BUILD_STATIC_LIBRARY)

