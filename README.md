# mopinion-sdk-ios
Mopinion Mobile SDK iOS

## Install

### Cocoapods

make a `Podfile` in root of your project:

```ruby
use_frameworks!
target '<YOUR TARGET>'
pod 'MopinionSDK'
pod 'React', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'yoga', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'DoubleConversion', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'GLog', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'Folly', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
```

Install the needed pods:

`$ pod install`

### fonts

Add this font to your app's `info.plist` > `Fonts provided by application`:   
- `Frameworks/MopinionSDK.framework/FontAwesome.ttf`

## Implement

in the `AppDelegate.swift` file of your app put:

```swift
import MopinionSDK
...
// debug mode
MopinionSDK.load(<MOPINION DEPLOYMENT KEY>, true)
// live
MopinionSDK.load(<MOPINION DEPLOYMENT KEY>)
```

in a UIViewController, for example `ViewController.swift`, put:

```swift
import MopinionSDK
...
MopinionSDK.event(self, "_button")
```
where `"_button"` is the default passive form event.
You can also make custom events and use them in the Mopinion deployment interface.

## Edit triggers

The custom defined events can be used in combination with rules:

* trigger: `passive` or `proactive`. A passive form always shows when the event is triggered. A proactive form only shows once, you can set the refresh time after which the form should show again.  
* percentage (proactive trigger): % of users that should see the form  
* date: only show the form at at, after or before a specific date or date range  
* time: only show the form at at, after or before a specific time or time range  
* target: the OS the form should show (iOS or Android)  
