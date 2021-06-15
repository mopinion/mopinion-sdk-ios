# Mopinion Mobile SDK iOS

The Mopinion Mobile SDK can be used to collect feedback from iOS apps based on events.
To use Mopinion mobile feedback forms in your app you can include the SDK as a Framework in your Xcode project.

There is also a Mopinion Mobile SDK for Android available [here](https://github.com/mopinion/mopinion-sdk-android).

You can see how your mobile forms will look like in your app by downloading our [Mopinion Forms](https://itunes.apple.com/nl/app/mopinion-forms/id1376756796?l=en&mt=8) preview app from the Apple iOS App Store.

## Release notes for version 0.4.5

### Changes in 0.4.5
- SDK format converted to xcframework. 
- Migrated to react-native 0.61.5 (breaking change).

### New features in 0.4.5
- Support for iOS Simulator on ARM Macs.
- Smaller screenshot thumbnail.
- Press thumbnail to display a larger preview.

### Improvements
- Fix for in-app forms rating/score labels that start hidden.
- Lower size of screenshot images.
- Patch to fix image display issues with react-native 0.61.5.
- Patch to fix react-native versions < 0.64.1 for Xcode 12.5 compatibility.

Note: Our SDK has been tested with react-native version 0.61.5 (with some iOS patches) and Xcode 12.4 and 12.5.

## Install

The Mopinion Mobile SDK Framework can be installed by using the popular dependency manager [Cocoapods](https://cocoapods.org).
The SDK is partly built with [React Native](https://facebook.github.io/react-native/), it needs some Frameworks to function.

### Install with Cocoapods and React Native (Node.js)

First, install the React Native frameworks using Node.js. 

[Install Node.js/npm](https://www.npmjs.com/get-npm) via either [macports](https://macports.org) or homebrew.

Then, make a `package.json` file in the root of your project:

```javascript
{
  "name": "YourApp",
  "version": "0.0.1",
  "scripts": {
    "postinstall": "patch-package"
  },
  "dependencies": {
    "@react-native-community/async-storage": "^1.12.1",
    "patch-package": "^6.4.6",
    "react": "16.9.0",
    "react-native": "0.61.5",
    "react-native-webview": "^11.6.2"
  }
}
```

From the terminal, also download our folder [`patches`](https://github.com/mopinion/mopinion-sdk-ios/tree/master/patches) with its content into the location where your `package.json` file resides:

```sh
$ mkdir patches
$ curl https://raw.githubusercontent.com/mopinion/mopinion-sdk-ios/master/patches/react-native+0.61.5.patch --output patches/react-native+0.61.5.patch
```

It contains a fix for react-native 0.61.5 on iOS. 

Next, execute:
`$ npm install`

Now create a `Podfile` like this (assuming the `node_modules` folder is in the same location as your `Podfile`) to install everything with [Cocoapods](https://cocoapods.org/)  :

```ruby
platform :ios, '9.0'
use_frameworks!
target '<YOUR TARGET>' do
	pod 'MopinionSDK',  '>= 0.4.5'
  # React Core components
  pod 'FBLazyVector', :path => "./node_modules/react-native/Libraries/FBLazyVector"
  pod 'FBReactNativeSpec', :path => "./node_modules/react-native/Libraries/FBReactNativeSpec"
  pod 'RCTRequired', :path => "./node_modules/react-native/Libraries/RCTRequired"
  pod 'RCTTypeSafety', :path => "./node_modules/react-native/Libraries/TypeSafety"
  pod 'React', :path => './node_modules/react-native/'
  pod 'React-Core', :path => './node_modules/react-native/'
  pod 'React-Core/DevSupport', :path => './node_modules/react-native/'
  pod 'React-Core/RCTWebSocket', :path => './node_modules/react-native/' # needed for debugging
  pod 'React-CoreModules', :path => './node_modules/react-native/React/CoreModules'
  pod 'React-RCTActionSheet', :path => './node_modules/react-native/Libraries/ActionSheetIOS'
  pod 'React-RCTBlob', :path => './node_modules/react-native/Libraries/Blob'
  pod 'React-RCTLinking', :path => './node_modules/react-native/Libraries/LinkingIOS'
  pod 'React-RCTNetwork', :path => './node_modules/react-native/Libraries/Network'
  pod 'React-RCTSettings', :path => './node_modules/react-native/Libraries/Settings'
  pod 'React-RCTText', :path => './node_modules/react-native/Libraries/Text'
  pod 'React-RCTVibration', :path => './node_modules/react-native/Libraries/Vibration'
  pod 'React-RCTAnimation', :path => './node_modules/react-native/Libraries/NativeAnimation'
  pod 'React-RCTImage', :path => './node_modules/react-native/Libraries/Image'
  pod 'React-cxxreact', :path => './node_modules/react-native/ReactCommon/cxxreact'
  pod 'React-jsi', :path => './node_modules/react-native/ReactCommon/jsi'
  pod 'React-jsiexecutor', :path => './node_modules/react-native/ReactCommon/jsiexecutor'
  pod 'React-jsinspector', :path => './node_modules/react-native/ReactCommon/jsinspector'
  pod 'ReactCommon/jscallinvoker', :path => "./node_modules/react-native/ReactCommon"
  pod 'ReactCommon/turbomodule/core', :path => "./node_modules/react-native/ReactCommon"
  # React-native-community components
  pod 'RNCAsyncStorage', :path => './node_modules/@react-native-community/async-storage'
  # Replacement without UIWebView for builtin RTCWebView of RN 0.59.10
  pod "react-native-webview", :path => "./node_modules/react-native-webview/react-native-webview.podspec"

  # Third party deps podspec link
  pod 'DoubleConversion', :podspec => './node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
  pod 'glog', :podspec => './node_modules/react-native/third-party-podspecs/glog.podspec'
  pod 'Folly', :podspec => './node_modules/react-native/third-party-podspecs/Folly.podspec'
  # Explicitly include Yoga if you are using RN >= 0.42.0
  pod 'Yoga', :path => "./node_modules/react-native/ReactCommon/yoga"

end

# ==== Below patch to use older RN versions < 0.64.1 with new Xcode 12.5 or up 
# https://github.com/facebook/react-native/issues/31412
 post_install do |installer|
   ## Fix for XCode 12.5
       find_and_replace("./node_modules/react-native/React/CxxBridge/RCTCxxBridge.mm",
       "_initializeModules:(NSArray<id<RCTBridgeModule>> *)modules", "_initializeModules:(NSArray<Class> *)modules")
       find_and_replace("./node_modules/react-native/ReactCommon/turbomodule/core/platform/ios/RCTTurboModuleManager.mm",
       "RCTBridgeModuleNameForClass(module))", "RCTBridgeModuleNameForClass(Class(module)))")
   end
 
 def find_and_replace(dir, findstr, replacestr)
   Dir[dir].each do |name|
       text = File.read(name)
       replace = text.gsub(findstr,replacestr)
       if text != replace
           puts "Fix: " + name
           File.open(name, "w") { |file| file.puts replace }
           STDOUT.flush
       end
   end
   Dir[dir + '*/'].each(&method(:find_and_replace))
 end
```

And perform a
 
`$ pod install`

After this you should use the newly created `<YourApp>.xcworkspace` file in Xcode.

Note: first time Xcode may fail to build your xcworkspace. Clean and build/run it again usually solves this error.

### font

The SDK includes a font that should be added to the fonts list in the `Info.plist` file of your project.

In Xcode, add this font to your app's `Info.plist` > `Fonts provided by application`:   
- `Frameworks/MopinionSDK.framework/FontAwesome.ttf`

## Implement the SDK

In your app code, for instance the `AppDelegate.swift` file, put:

```swift
import MopinionSDK
...
// debug mode
MopinionSDK.load(<MOPINION DEPLOYMENT KEY>, true)
// live
MopinionSDK.load(<MOPINION DEPLOYMENT KEY>)
```

The `<MOPINION DEPLOYMENT KEY>` should be replaced with your specific deployment key. This key can be found in your Mopinion account at the `Feedback forms` section under `Deployments`.

in a UIViewController, for example `ViewController.swift`, put:

```swift
import MopinionSDK
...
MopinionSDK.event(self, "_button")
```
where `"_button"` is the default passive form event.
You can also make custom events and use them in the Mopinion deployment interface.  
In the Mopinion system you can enable or disable the feedback form when a user of your app executes the event.
The event could be a touch of a button, at the end of a transaction, proactive, etc.

## extra data

From version `0.3.1` you can send extra data from the app to your form. 
This can be done by adding a key and a value to the `data()` method.
The data should be added before the `event()` method is called if you want to include the data in the form that comes up for that event.

```swift
MopinionSDK.data(_key: String, _value: String)
```

Example:
```swift
import MopinionSDK
...
MopinionSDK.data("first name": "Steve")
MopinionSDK.data("last name": "Jobs")
...
MopinionSDK.event(self, "_button")
```

## clear extra data

From version `0.3.4` it's possible to remove all or a single key-value pair from the extra data previously supplied with the `data(key,value)` method.
To remove a single key-value pair use this method:

```swift
MopinionSDK.removeData(forKey: String)
```
Example:

```swift
MopinionSDK.removeData(forKey: "first name")
```

To remove all supplied extra data use this method without arguments:

```swift
MopinionSDK.removeData()
```
Example:

```swift
MopinionSDK.removeData()
```

## Edit triggers

In the Mopinion system you can define events and triggers that will work with the SDK events you created in your app.
Login to your Mopinion account and go to the form builder to use this functionality.

The custom defined events can be used in combination with rules:

* trigger: `passive` or `proactive`. A passive form always shows when the event is triggered. A proactive form only shows once, you can set the refresh time after which the form should show again.  
* percentage (proactive trigger): % of users that should see the form  
* date: only show the form at at, after or before a specific date or date range  
* time: only show the form at at, after or before a specific time or time range  
* target: show the form only in the specified OS (iOS or Android)
