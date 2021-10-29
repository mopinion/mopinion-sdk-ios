# Mopinion Mobile SDK iOS

The Mopinion Mobile SDK can be used to collect feedback from iOS apps based on events.
To use Mopinion mobile feedback forms in your app you can include the SDK as a Framework in your Xcode project.

There is also a Mopinion Mobile SDK for Android available [here](https://github.com/mopinion/mopinion-sdk-android).

You can see how your mobile forms will look like in your app by downloading our [Mopinion Forms](https://itunes.apple.com/nl/app/mopinion-forms/id1376756796?l=en&mt=8) preview app from the Apple iOS App Store.

### Contents

- Release notes
- [Installation](#install)
- [Implement the SDK](#implement)
- [Submitting extra data](#extra-data)
- [Using callback mode](#callback-mode)
- [Edit triggers](#edit-triggers)

## Release notes for version 0.5.0

### New features in 0.5.0
- 3 new variants of the method `event()` add an asynchronous callback response `onMopinionEvent()` as part of the protocol `MopinionCallbackEventDelegate`, to let you receive a certain `MopinionCallbackEvent` from the SDK about the feedback form.
- the new variants of the method `event()` include an asynchronous callback response `onMopinionEventError()` as part of the protocol `MopinionCallbackEventErrorDelegate` to inform you of errors and allow use with delegates or closures. 
- Currently supported `MopinionCallbackEvents` are when the form is displayed, when the user submitted the form or when the form closed.
- The callback includes an object `MopinionResponse` that can optionally contain data associated with some events. Data can be for example the form key, the form name or miscellanous data as dictionary (Foundation representation of a JSONObject).
- The new callback behaviour is optional. You don't need to change your existing code, the SDK by default will behave as before without making callbacks.

### Remarks
- Our SDK has been tested with react-native version 0.61.5 (with some iOS patches) and Xcode 13.
- Tip: If you don't see design changes to forms coming through in your app during development, remove and re-install your app. That will clear the device cache, which normally can take several hours to refresh.

## <a name="install">Install</a>

The Mopinion Mobile SDK Framework can be installed by using the popular dependency manager [Cocoapods](https://cocoapods.org).
The SDK is partly built with [React Native](https://facebook.github.io/react-native/), it needs some Frameworks to function.

### Install CocoaPods native on ARM based Macs
Macs with an ARM processor need a newer Ruby toolchain to use CocoaPods via a network. To prevent ffi errors `LoadError - dlopen(/Library/Ruby/Gems/2.6.0/gems/ffi-1.14.2/lib/ffi_c.bundle, 0x0009)` causing build failures:

1. Install the Xcode 12.5 (or later) *Command Line* tools (even if you already installed the full Xcode IDE version)
2. Install [macports](https://macports.org)
3. In terminal, execute 

```sh
sudo port install ruby27
sudo port select --set ruby ruby27
source .zprofile # or .profile, whereever you defined your $PATH
sudo gem update
sudo gem install ffi
sudo gem install cocoapods
```
Tested to work with M1 on macOS Big Sur 11.4, Xcode 12.5, macports 2.7.1, ruby 2.7.3p183, cocoapods 1.10.1

#### Reported native cocoapods install for homebrew users
For homebrew users the procedure is a bit different, [according to github](https://github.com/CocoaPods/CocoaPods/issues/9907#issuecomment-835385306):

1. Update to at least macOS Big Sur 11.3.1
2. Install homebrew
3. Update ruby to at least 2.7.3

```sh
brew install rbenv
rbenv init
rbenv install 2.7.3
export RBENV_VERSION=2.7.3 # or however you set your ruby version
```
4. Install cocoapods 

```sh
brew install cocoapods
```

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
    "react-native-webview": "11.6.2"
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
	pod 'MopinionSDK',  '>= 0.5.0'
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

<br>

## <a name="implement">Implement the SDK</a>

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
<br>

## <a name="extra-data">extra data</a>

From version `0.3.1` you can send extra data from the app to your form. 
This can be done by adding a key and a value to the `data()` method.
The data should be added before the `event()` method is called if you want to include the data in the form that comes up for that event.

```swift
MopinionSDK.data(_ key: String, _ value: String)
```

Example:

```swift
import MopinionSDK
...
MopinionSDK.data("first name", "Steve")
MopinionSDK.data("last name", "Jobs")
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

<br>

## <a name="callback-mode">Using callback mode</a>
By default the SDK manages the feedback form autonomously without further involving your app. 
SDK version `0.5.0` introduces callbacks to inform your code of certain actions (MopinionCallbackEvent). 

Provide a callback handler to receive a response, containing either data or possible error information. 


### Procedure overview

1. Call the `event()` method and pass it a callback method that implements the `MopinionCallbackEventDelegate.onMopinionEvent` protocol.
2. In your callback method `onMopinionEvent()`, check the kind of `mopinionEvent` and optionally call `didSucceed()` or `hasErrors()` on the `response` to check for errors.
3. Optionally, call `hasData()` on the `response` object to check if there is data.
4. Depending on the kind of `mopinionEvent`, check for the presence of data specified by a `ResponseDataKey` using the call `hasData(ResponseDataKey)` on the `response`.
5. To get the data, call `getString(ResponseDataKey)` respectively `getJSONObject(ResponseDataKey)` on the `response`, depending on the type of data to retrieve.

You can also provide an optional error-callback handler to `event()` to seperately receive responses with error information. In that case the primary handler only receives responses without errors.

<br>

### Callback variants of the `event()` method
Triggers an event you defined in your deployment to open a form and receive MopinionCallbackEvent callbacks. If you don't specify a failHandler, the callback handler will also receive error responses.


```swift
func event(parentView: event: onCallbackEvent:  onCallbackEventError:)
func event(parentView: event: onCallbackEventDelegate:)
func event(parentView: event: onCallbackEventDelegate:  onCallbackEventErrorDelegate:)
```

Parameters:

* `parentView`: The UIViewController that serves as parent view of the app.
* `event`: The name of the event as defined in the deployment for the form. For instance "_button".
* `onCallbackEvent`: a closure implementing the `onMopinionEvent()` callback.
* `onCallbackEventError`: a closure implementing the `onMopinionEventError()` callback for MopinionCallbackEvents that resulted in errors.
* `onCallbackEventDelegate`: The object implementing the `MopinionCallbackEventDelegate` protocol to handle the `onMopinionEvent()` callback.
* `onCallbackEventErrorDelegate`: The object implementing the `MopinionCallbackEventErrorDelegate` protocol to handle the `onMopinionEventError()` callback for MopinionCallbackEvents that resulted in errors.

<br>

### Callback methods `onMopinionEvent()` and `onMopinionEventError()`

These methods you implement in your code to receive MopinionCallbackEvents. They have the same parameters to pass you a response with optional additional information. 
What information is provided depends on the type of `MopinionCallbackEvent` and its origin.

```swift
func onMopinionEvent(mopinionEvent: MopinionCallbackEvent, response: MopinionResponse)
func onMopinionEventError(mopinionEvent: MopinionCallbackEvent, response: MopinionResponse)
```

Parameters:

* `mopinionEvent`: The kind of response event that you receive from the SDK. Currently one of the following:
	* `FORM_OPEN` : when the form is shown
	* `FORM_SENT` : when the user has submitted the form
	* `FORM_CLOSED` : when the form has closed

* `response`: The MopinionResponse object containing additional information on the MopinionEvent. The response is never `nil`, but use its `hasData()` methods to check if it contains any additional data, or `hasErrors()` for errors.

<br>

### MopinionResponse object
The data collection present in this object depends on the kind of MopinionCallbackEvent and its origin. The data is a key-value collection. Both data and errors can be missing. The response object contains methods to inspect and retrieve them. 


#### Getting data with `response.get()` and `response.hasData()`
Check with `hasData(key)` first, as the `get<>(key)` methods can return `null`. Pass a standard `ResponseDataKey` to these methods for the data you're interested in.

ResponseDataKey|Method to read it|Description
---|---|---
DATA_JSONOBJECT|.getJSONObject()|dictionary of the 'raw' JSONObject with all available data
FORM_KEY|.getString()|the internal unique identifier for the form
FORM_NAME|.getString()|the name of the form. Distinct from the title of the form.

<br>

#### MopinionCallbackEvents and provided data in `response`
This is the data that can be present for a certain MopinionCallbackEvent:

MopinionCallbackEvent|ResponseDataKeys|Remarks
---|---|---
FORM_OPEN|DATA_JSONOBJECT|
&nbsp;|FORM_KEY|
&nbsp;|FORM_NAME|
FORM_SENT|DATA_JSONOBJECT|
&nbsp;|FORM_KEY|
&nbsp;|FORM_NAME|
FORM_CLOSED|DATA_JSONOBJECT|Currently only automatically closed forms provide data 
&nbsp;|FORM_KEY|only when autoclosed
&nbsp;|FORM_NAME|only when autoclosed

The order in which MopinionCallbackEvents occur is:

	1. FORM_OPEN
	2. FORM_SENT (only if the user submits a form)
	3. FORM_CLOSED

<br>

#### Reading `response` errors
Call `response.hasErrors()` , followed by `response.getError()` to get the error object.
The `getError()` method might return `nil`.

<br>

### Callback handler example to run code after send
Pseudo code to show the usage of the `event()` callback with closures and some involved objects to implement running code after send.
You must wait for the form to be closed after send before running any code affecting your own UI.

```swift
...
import MopinionSDK
...
// assuming that in your AppDelegate, you already did MopinionSDK.load(<MOPINION DEPLOYMENT KEY>)
...
class YourViewController: UIViewController, MopinionOnEvaluateDelegate {
...
    var wasFormSent: Bool = false	// track state outside closure
...
    func demonstrateMopinionCallback() {
        self.wasFormSent = false
    
        // open the form associated with the event "_myfeedbackbutton" from the deployment and receive callbacks in the closures        
        MopinionSDK.event(self, "_myfeedbackbutton", onCallbackEvent: {  (mopinionEvent, response) -> (Void) in
            print("callback in success closure")
            if(mopinionEvent == .FORM_SENT) {
                let formKey = response.getString(.FORM_KEY)!
                print("The form with formKey=\(formKey) has been sent, but is still displayed")
                self.wasFormSent = true
            } else if(mopinionEvent == .FORM_CLOSED) {
                if(self.wasFormSent) {
                    let formKey = response.getString(.FORM_KEY) ?? ""
                    print("The form \(formKey) has beent sent and closed, now you can run some code.")
                }
            }

        }, onCallbackEventError: { (mopinionEvent, response) -> (Void) in
            let myError = response.getError();
            print("there was an error during callback: \(String(describing: myError))")
        } )
	}
...
}
...
```

<br>

## <a name="edit-triggers">Edit triggers</a>

In the Mopinion deployment editor you can define event names and triggers that will work with the SDK event names that you used in your app.
Login to your Mopinion account and go to `Data collection`, `Deployments` to use this functionality.

![Deployment Editor](images/deployment_edit_triggers.png)

The custom defined events can be used in combination with rules/conditions:

* trigger: `passive` or `proactive`. A passive form always shows when the event is triggered. A proactive form only shows once, you can set the refresh time after which the form should show again.  
* submit: allow opening a proactive form until it has been submitted at least once. This affects the trigger rule, to allow opening a form more than once. Support for this appeared in SDK version 0.4.3.
* percentage (proactive trigger): % of users that should see the form  
* date: only show the form at, after or before a specific date or date range  
* time: only show the form at, after or before a specific time or time range  
* target: show the form only in the specified OS (iOS or Android)
