LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= sqlite3

ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
  LOCAL_CFLAGS := -fPIC -O1 -fno-strict-aliasing -fomit-frame-pointer -march=armv8-a
  LOCAL_ARM_NEON := true
endif
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  LOCAL_CFLAGS := -fPIC -O1 -fno-strict-aliasing -fomit-frame-pointer -mfloat-abi=softfp -mfpu=vfpv3-d16 -march=armv7-a
  LOCAL_ARM_MODE := arm
endif
ifeq ($(TARGET_ARCH_ABI),armeabi)
  LOCAL_CFLAGS := -fPIC -Os -fno-strict-aliasing -fomit-frame-pointer -mfloat-abi=softfp -mfpu=vfp -march=armv5te
  LOCAL_ARM_MODE := thumb
endif
ifeq ($(TARGET_ARCH),mips)
  LOCAL_CFLAGS := -fPIC -O1 -fno-strict-aliasing -fomit-frame-pointer
endif
ifeq ($(TARGET_ARCH),x86_64)
  LOCAL_CFLAGS := -fPIC -O1 -fno-strict-aliasing -fomit-frame-pointer -malign-double -march=x86-64 -mtune=intel -msse4.2 -mpopcnt -fno-stack-protector
endif
ifeq ($(TARGET_ARCH),x86)
  LOCAL_CFLAGS := -fPIC -O1 -fno-strict-aliasing -fomit-frame-pointer -malign-double -march=i686 -mtune=intel -mssse3 -mfpmath=sse -fno-stack-protector
endif

LOCAL_SRC_FILES:= sqlite3.c

LOCAL_CFLAGS += -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_ENABLE_COLUMN_METADATA

include $(BUILD_STATIC_LIBRARY)

