# CometChatPro-UIKit

(Not yet hooked up to CI, coming soon)

[![CI Status](https://img.shields.io/travis/DanBurkhardt/CCPMessenger.svg?style=flat)](https://travis-ci.org/DanBurkhardt/CCPMessenger)
[![Version](https://img.shields.io/cocoapods/v/CCPMessenger.svg?style=flat)](https://cocoapods.org/pods/CCPMessenger)
[![License](https://img.shields.io/cocoapods/l/CCPMessenger.svg?style=flat)](https://cocoapods.org/pods/CCPMessenger)
[![Platform](https://img.shields.io/cocoapods/p/CCPMessenger.svg?style=flat)](https://cocoapods.org/pods/CCPMessenger)

A unified framework for CometChat Pro UIKit, and the CometChat SDK.

## Features / Updates

**Version 1.1.0**

- ✅ Ability to build for Xcode Simulator restored with incorporation CometChat Pro SDK 2.1.1
- ✅ Fully tested for use with iOS 14
- ✅ Push notification auto-registration reliability improvements
- ✅ Improved media player window on iPad for voice memos

**Version 1.0**

- ✅ Combined framework with both UIKit & binary SDK in one pod
- ✅ Same convenient & official CometChat Pro SDK & service
- ✅ UIViewController extensions to launch CometChatPro from any ViewController
- ✅ Automatic push notification integration with Firebase (if configured)
- ✅ Automatic chat topic & group chat push notification registration (Firebase)
- ✅ Automatic new user creation on initial login if user doesn't exist
- ✅ Enhanced media player previews for iPad as UIPopover
- ✅ Fully-integrated UIKit front-end implementation
- ✅ Privacy access level scoped so as not to collide with your project files
- ✅ Easy instantion & configuration
- ✅ Separate asset & source files from your project to reduce clutter
- ✅ No reduction of CometChat Pro's functionality & usability
- ✅ Testable for future open-source development CI integration


**Known Issues / WIP**

- In order to build locally, you need minimum Cocoapods version 1.10.0.rc.1
    - if you are not running, either update to the latest release, or run `sudo gem install cocoapods --pre`
- Full restoration of video & audio calling in progress, not totally functional in v1.1

## Usage Examples

> All of these functions are documented, see QuickHelp for more info.

**Setup a User**

- Map these values from your local user GUID & profile info

```swift
let user: CCPUser = .init(firstname: first, lastname: last, uid: uuid)

```
<br>

**Login**

- Available globally as a shared instance

	```swift
	// Method Signature
	// CCPHandler.shared.login(user: CCPUser, completion: (Bool) -> Void)
	
	CCPHandler.shared.login(user: user) { (success) in {
		// present cometchat
	}
	```
<br>

**Logout**

- Logs the user out of CometChat
- Automatically unsubcribes the user’s device from all personal push notification topics & group chat topics

	```swift
	CCPHandler.shared.logout()
	```
<br>

**Present CometChat from any View Controller**

- Available to any `UIViewController` within the import scope

	```swift
	// Method signature
	// presentCometChatPro(withStyle: UIModalPresentationStyle?UIModalPresentationStyle, animated: Bool, completion: (() -> Void)?)
	
	presentCometChatPro(.fullScreen, animated: true) {
            print("presented")
        }
	
	```

<br>

**Get an instance of CometChatUnified to present**

- Available to any `UIViewController` within the import scope
- Useful for when needing to present on a `UIScene` or some other custom navigation stack situation

	```swift
	// Method signature
	// getCometChatPro(setupWithStyle: UIModalPresentationStyle?)
	
	let cometChat: CometChatUnified = getCometChatPro(.fullScreen)
	// do something custom
	
	```

<br>

**Subscribe / Unsibscribe from Push Topics Manually**

- Convenient wrapper for Firebase messaging
- You do not need to manually subscribe to any user or group topics, that is automatically handled when logging into CometChat


	```swift
	CCPHandler.shared.subscribeTo(topic: “topic string”)
	CCPHandler.shared.unSubscribe(topic: “topic string”)
	```


## Installation

CometChatPro-UIKit is (not yet available through [CocoaPods](https://cocoapods.org)). To install
it, simply add the following line to your Podfile:

```ruby
# For now, due to some issues with static framework
# support in cocoapods, pod lib lint is getting hung

# target the source repo while we're working on shipping
# to trunk

pod 'CometChatPro-UIKit', :git => 'https://github.com/GigabiteLabs/CometChatPro-UIKit.git'
```


## Requirements & Dependencies

- Minimum version: iOS 13.0^
- CometChatPro SDK 2.1.1
- Firebase/Messaging framework (push notifications)

There are a few dependencies required to use this framework.

In order to reduce dependency re-building, `cocoapods-binary` is used in the example.

- You can install by running `gem install cocoapods-binary` 
- You can read [about it here](cocoapods-binary).
- If you do not want to install it, simply omit the `plugin` line from the example below, and also omit  the `, :binary => true` directives.

This is a suggested Podfile based on the example:

```ruby
# Min target
plugin ‘cocoapods-binary’
platform :ios, ’13.0’
	
## Pod install settings
## Configured for using separate projects (more performant)
install! ‘cocoapods’,
generate_multiple_pod_projects: true,
incremental_installation: true
use_modular_headers!
use_frameworks!
	
# Open Source Cocoapods
source ‘https://cdn.cocoapods.org’
target ‘CometChatPro-UIKit_Example’ do
  pod ‘Firebase’
  pod ‘Firebase/Messaging’
  pod ‘CometChatPro’, ‘2.0.12-Xcode11.4’, :binary => true
  pod ‘IQKeyboardManager’, :binary => true
  pod ‘CometChatPro-UIKit’, :path => ‘../‘
  target ‘CometChatPro-UIKit_Example_Tests’ do
    inherit! :search_paths
    pod ‘CometChatPro-UIKit’, :path => ‘../‘
  end
end
```


## Setup & Configuration

*Note: This framework diverges from official CometChat documentation in many key ways because it is a derivative work. Until / unless it is adopted by CC, we'll maintain mostly-separate documentation in this README.*

**AppDelegate Setup & Config**

- Open your `AppDelegate` file
- In your `didFinishLaunching` function, add the following:

```swift
    // import at the top of AppDelegate
    import CometChatPro_UIKit

    // configure with your account credentials
    CCPConfig.shared.apiKey = “your api key”
    CCPConfig.shared.appId = “your app id”
    CCPConfig.shared.region = “your app region”

    // all CometChatPro's config builder
    let mySettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: CCPConfig.shared.region).build()
    let _ = CometChat(appId: CCPConfig.shared.appId,appSettings: mySettings,onSuccess: { (isSuccess) in
    if (isSuccess) {
        print("Chat intialized successfully.")
    }}){ (error) in
        print("CometChat failed intialise with error: \(error.errorDescription)")
    }
```

- The `CCPConfig.shared` instance is the central point for all application configuration & setup

<br>

> Note: All public files available from this framework are prefixed with '`CCP`', which stands for CometChatPro.

<br>

**Login**

    ```swift
    func launch(first: String, last: String, uuid: String) {
        let user: CCPUser = .init(firstname: first, lastname: last, uid: uuid) // 1
        CCPHandler.shared.login(user: user) { (success) in  // 2
            self.presentCometChatPro(.fullScreen, animated: true, completion: nil) // 3
        } // 4
    }
    ```

**Xcode Project Config**

As per [the CometChat Docs](https://prodocs.cometchat.com/docs/ios-quick-start#section-setup-bitcode), you’ll need to set some config for your project:

<img src="https://gigabitelabs.com/codeassets/readmes/cometchatprouikit/v1.0/xcconfig.png" width="700" height="1000"/>

### Example Project

First, you’ll need a Firebase config file. Checkout the docs for how to set that up.

To run the example project:

- clone the repo
- cd to Example/
- run `pod install`
- when finished, run `open -a xcode ./*.xcworkspace`
- Copy your Firebase `.plist` file to Example/CometChatPro-UIKit_Example/Resources

Next, you need to add some environment variables.
It’s important not to commit authentication data / keys, so the CometChatPro APIKey, AppID, & Region are sourced from environment variables. 

You should do the following:

- Open project
- Click on the scheme
- Click on edit scheme
- Click on the example scheme & duplicate it
- Rename it
- **make sure it is not shared**
- You now have an env that will not get pushed to Git.

Here’s how to add the vars:

- Edit: scheme>run>arguments>environment variables
- Like so:

<img src="https://gigabitelabs.com/codeassets/readmes/cometchatprouikit/v1.0/vars.png" width="700" height=“300”/>

Again, do not share your env, it defeats the purpose:

<img src="https://gigabitelabs.com/codeassets/readmes/cometchatprouikit/v1.0/unshare_scheme.png " width= "400" height=“300”/>

<br>



## Author

[Dan Burkhardt](https://github.com/DanBurkhardt)
Founder, Lead Engineer @[GigabiteLabs](https://gigabitelabs.com).
Get [in touch](mailto:engineering@gigabitelabs.com).

### Why We Wrote This Framework

CometChat is a personal favorite. It's perhaps the best non-BIG_SOCIAL chat framework. We're super down with the little guy, and we like the company. But it was clear that the use of CometChat as our go-to was going to go away if we didn't get some major issues resolved by way of a framework like this.

Before we made this framework, the process for implementing the CometChat UIKit interface was the following:

- Install the CometChat closed-source SDK via [Cocoapods](https://github.com/cometchat-pro/ios-chat-sdk)
- Visit the [CometChat](https://prodocs.cometchat.com/docs/ios-quick-start) documentation site
- *Download the files* for the [UIKit](https://github.com/cometchat-pro/ios-swift-chat-app) library
- Copy files to project
- **Spend the next while putting out filename, property, and variable override fires**

Without a carefully frameworked, privacy conscious approach, this massive codebase crushed our projects every time we updated it with a new version by pasting in new files. 

Specifically:

- CometChat's UIKit framework uses @IBInspectable variables that are not guarded with any particular level of privacy access. We have an internal standard library that implements @IBInspectables for the exact same properties, do every update was a top-down repeat of the same refactoring we did during the last CometChat UIKit library update.
- Filenames are SUPER generic, like `User`. We already have a file called `User`, and we do not want to change that, but the CC UIKit library colided with it in all of our projects
- Our application's assets and the 3rd party assets of the UIKit library were sitting in the same directory, with very similar names, making it super hard to figure out which was which
- A very important production build was delayed due to these issues, so we said enough was enough.

And then we fixed it. And refactored the whole library to fit within the framework paradigm. And it works quite well!

It is our hope that this is fully adopted by the team at CometChat, and that it will become the new standard distribution method for CometChat.

## Licenses

CCPMessenger is available under the MIT license. See the LICENSE file for more info.

CometChat Pro UIKit & Binary framework is available unter the "CometChat" license. See COMETCHAT_LICENSE for more info.
