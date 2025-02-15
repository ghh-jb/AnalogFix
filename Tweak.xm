#include <Foundation/Foundation.h>

@interface TFCoreUtils : NSObject
+(BOOL)tf_deviceHasFaceID;
+(BOOL)tf_deviceHasTopPowerButton;
+(id)tf_screenshotInstructionImageDict;
@end

@interface UIDevice : NSObject
@end


%group Crash
%hook UIDevice
%new
+(BOOL)tf_deviceHasFaceID {
	return [%c(TFCoreUtils) tf_deviceHasFaceID];
}
%end
%end

%ctor {
	NSLog(@"[AF] Crash fix!");
	%init(Crash);
}