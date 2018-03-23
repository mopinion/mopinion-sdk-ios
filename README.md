# mopinion-sdk-ios
Mopinion Mobile SDK iOS

## Install

### Cocoapods

make `Podfile` in root of your project:

```ruby
use_frameworks!
target '<YOUR TARGET>'
pod 'MopinionSDK', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'React', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'yoga', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'DoubleConversion', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'GLog', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
pod 'Folly', :git => 'git@github.com:mopinion/mopinion-sdk-ios.git'
```

`$ pod install`

### fonts

Add these fonts to `info.plist` > `Fonts provided by application`:   
- `Frameworks/MopinionSDK.framework/MaterialIcons.ttf`   
- `Frameworks/MopinionSDK.framework/Roboto.ttf`