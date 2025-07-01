TARGET := iphone:clang:15.2:15.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = 000AnalogFix

000AnalogFix_FILES = Tweak.xm
000AnalogFix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
