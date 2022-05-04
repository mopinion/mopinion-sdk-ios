# 0.6.1
- Fixed an issue with iOS 15 where the extra/meta data and screenshot could disappear for forms of type "web".

# 0.6.0
- Introduced option for users to upload an image from their device as a screenshot.
- Requires at least iOS 11 to run.
- 32-bit devices are no longer supported.
- Migrated to react-native version 0.66.3 and Xcode 13.1

# 0.5.0
- Introduced `MopinionCallbackEvents` for when a form is displayed, the user has submitted a form or when a form closed.

# 0.4.5
- SDK framework format converted to xcframework. 
- Migrated to react-native 0.61.5.
- Support for Xcode 12.5.1, iOS Simulator on ARM Macs.
- Smaller screenshot size & thumbnail, larger preview.

# 0.4.4
- removed UIWebView. Xcode 11.4.1

# 0.4.3
- Autoclose of webforms.
- Allow weblinks to open browser.
- New trigger rule: submit-rule. Allows opening a proactive form until it has been submitted at least once.
- improved random. Xcode 11.4

# 0.4.2
- rebuilt with Xcode 11.2.1

# 0.4.1
- Swift 5.1.2 support.

# 0.4.0
- Swift 5.1/Xcode 11/iOS 13 support. 
- react-native 0.59.9.

# 0.3.5
- Same as 0.4.0 but built for Swift 5.0/Xcode 10.3.

# 0.3.4
- New method `removeData()` to remove all or a single key-value pair from the extra data previously supplied with the data(key,value) method.
- Autolayout-fix for iOS11+.

# 0.3.1 
- New method `data()` to send extra data from the app to your form.