TARGET := iphone:clang:16.5:14.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SpinnerFix
SpinnerFix_FILES = Tweak.x
SpinnerFix_CFLAGS = -fobjc-arc
SpinnerFix_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
