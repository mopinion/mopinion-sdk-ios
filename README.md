# mopinion-sdk-ios
Mopinion Mobile SDK iOS

## Install

### Cocoapods

make `Podfile` in root of your project:

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

`$ pod install`

### fonts

Add this font to `info.plist` > `Fonts provided by application`:   
- `Frameworks/MopinionSDK.framework/FontAwesome.ttf`

## Implement

in the `AppDelegate.swift` file of your app put:

```swift
import MopinionSDK
...
// debug mode
MopinionSDK.load("3t5sg11dpm3vrpoquxirnsdvi4dff12y4vv", true)
// live
MopinionSDK.load("3t5sg11dpm3vrpoquxirnsdvi4dff12y4vv")
```

in a UIViewController, for example `ViewController.swift`, put:

```swift
import MopinionSDK
...
MopinionSDK.event(self, "click_1")
```
where `"click_1"` is a custom event you name yourself.

## Edit triggers

The custom defined events can be used in combination with rules:

* trigger: `passive` or `proactive`. A passive form always shows when the event is triggered. A proactive form only shows once, you can set the refresh time after which the form should show again.  
* percentage: % of users that should see the form  
* date: only show the form at at, after or before a specific date or date range  
* time: only show the form at at, after or before a specific time or time range  
* target: the OS the form should show (iOS or Android)  
