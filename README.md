# Mopinion Mobile SDK iOS

The Mopinion Mobile SDK can be used to collect feedback from iOS apps based on events.
To use Mopinion mobile feedback forms in your app you can include the SDK as a Framework in your Xcode project.

There is also a Mopinion Mobile SDK for Android available [here](https://github.com/mopinion/mopinion-sdk-android).

## Install

The Mopinion Mobile SDK Framework can be installed by using the popular dependency manager [Cocoapods](https://cocoapods.org).
The SDK is partly built with [React Native](https://facebook.github.io/react-native/), it needs some Frameworks to function.

### Install with Cocoapods

Install Cocoapods

`$ sudo gem install cocoapods`

make a `Podfile` in root of your project:

```ruby
platform :ios, '9.0'
use_frameworks!
target '<YOUR TARGET>' do
	pod 'MopinionSDK'
	pod 'React', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
	pod 'yoga', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
	pod 'DoubleConversion', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
	pod 'GLog', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
	pod 'Folly', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
end
```

Install the needed pods:

`$ pod install`

After this you should use the newly made `.xcworkspace` file in Xcode.

### Install with Cocoapods and React Native (Node.js)

An alternative is to install the React Native frameworks via Node.js. 

[Install Node.js/npm](https://www.npmjs.com/get-npm)

make a `package.json` file in the root of your project:

```javascript
{
  "name": "MopinionSDK",
  "version": "0.1.4",
  "dependencies": {
    "react": "16.0.0",
    "react-native": "0.51.0"
  }
}
```

`$ npm install`

Now you can install everything with Cocoapods with a `Podfile` like this (assuming the `node_modules` folder is in the same location as your `Podfile`):

```ruby
platform :ios, '9.0'
use_frameworks!
target '<YOUR TARGET>' do
	pod 'MopinionSDK'
	pod 'React', :path => './node_modules/react-native', :subspecs => [
	  'Core',
	  'CxxBridge',
	  'DevSupport',
	  'RCTImage',
	  'RCTNetwork',
	  'RCTText',
	  'RCTWebSocket',
	  'RCTAnimation',
	]
	pod 'yoga', :path => './node_modules/react-native/ReactCommon/yoga'
	pod 'DoubleConversion', :podspec => './node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
	pod 'GLog', :podspec => './node_modules/react-native/third-party-podspecs/GLog.podspec'
	pod 'Folly', :podspec => './node_modules/react-native/third-party-podspecs/Folly.podspec'
end
```

`$ pod install`

After this you should use the newly made `.xcworkspace` file in Xcode.

### font

The SDK includes a font that should be added to the fonts list in the `info.plist` file of your project.

Add this font to your app's `info.plist` > `Fonts provided by application`:   
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

## Edit triggers

In the Mopinion system you can define events and triggers that will work with the SDK events you created in your app.
Login to your Mopinion account and go to the form builder to use this functionality.

The custom defined events can be used in combination with rules:

* trigger: `passive` or `proactive`. A passive form always shows when the event is triggered. A proactive form only shows once, you can set the refresh time after which the form should show again.  
* percentage (proactive trigger): % of users that should see the form  
* date: only show the form at at, after or before a specific date or date range  
* time: only show the form at at, after or before a specific time or time range  
* target: the OS the form should show (iOS or Android)  
