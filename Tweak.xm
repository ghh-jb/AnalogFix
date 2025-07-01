#include <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>

@interface TFCoreUtils : NSObject
+(BOOL)tf_deviceHasFaceID;
+(BOOL)tf_deviceHasTopPowerButton;
+(id)tf_screenshotInstructionImageDict;
@end

@interface UIDevice : NSObject
@end

// This fixes Preferences crashing
// They are trying to load preferences
// But not directly through /var/mobile/Library/Preferences
// But through /Users/Library/Preferences
//
// This Path does not exist on Fugu15_Rootful
// because we cant mutate root volume (SSV)
// This should work on other rootful jailbreaks (nekojb/palera1n) tho
const char* patch_path(const char* path) {
	NSString* nspath = [NSString stringWithUTF8String:path];
	if ([nspath hasPrefix:@"/User"]) {
		NSString *suffix = [nspath substringFromIndex:5];

		NSString *vmobile = @"/var/mobile";

		NSString *fixed = [vmobile stringByAppendingString:suffix];


		const char *param1 = [fixed UTF8String];
		NSLog(@"[AF::patch_path] new path: %s", param1);
		chmod(param1, 777); 
		// Idk why, but plist changes permissions to 
		// 500 or similar (without read permission) so 
		// apple  Preferences app crashes when opening
		// Analog preferences page
		// Fix it in this rude way before returning
		return param1;
	}
	return path;
}

// Now hook some file-management related functions
%hookf(int, open, const char *path, const char *mode) {
	return %orig(patch_path(path), mode);
}

%hookf(int, rename, const char *old_name, const char *new_name) {
	return %orig(patch_path(old_name), patch_path(new_name));
}

%hook UIDevice
%new
// This fixes Safe mode crash
// Btw, I tested this on rootless Dopamine (iOS 15.8)
// And it worked fine. 
// Ellekit is actually shitty, it does not
// crash into safe mode when UIKit crashes, and because of that it stucks in respring loop.
// Now - with reimplementation of this method
// (it is part of UIKit) this works on rootless too

+(BOOL)tf_deviceHasFaceID {
	return [%c(TFCoreUtils) tf_deviceHasFaceID];
}
%end

%ctor {
	NSLog(@"[AF] Crash fix!");
}