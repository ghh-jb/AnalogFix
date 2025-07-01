# AnalogFix
Fix Analog tweak SafeMode and preferences page crash on iOS 15. 
# Tested Devices and iOS Versions
- iPhone SE 2020; iOS 15.2; Fugu15_Rootful; libhooker
- iPhone 7; iOS 15.8; Dopamine; ellekit
# Compatibility
- iOS 15.0 and above
- arm64, arm64e
- Rootful and Rootless
# Building
1) Set up theos
2) Download iOS 15.2 sdk (or specify preferred one in ```Makefile```)
3) Run ```make package``` in project dir
4) Go to packages/ and locate deb
5) Install
# Original tweak
Q: How did you tested this on rootless?
A: I just used Xinam1ne patcher on original Analog V1.1 (get it on: https://www.ios-repo-updates.com). Dirty but easy. Correctly set-up patcher is a very powerful tool.

Q: I have some problems with this fix, what should I do?
A: Feel free to open issue and describe what exactly happens with crash log. Use OSAnalytics from PoomSmart or Cr4shed to find the culprit.
# DONE:
- Safe mode crash fixed
- Fixed preferences page crash
# License
MIT. See the ```LICENSE``` file.
