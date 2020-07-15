Pod::Spec.new do |s|
  s.name             = 'CometChatPro-UIKit'
  s.version          = '1.0.0'
  s.summary          = 'A unified framework for CometChat Pro UIKit and the CometChat SDK.'
  s.description      = <<-DESC
'A unified framework for CometChat Pro that combines the CometChat Pro UIKit library CometChat binary SDK.'
                       DESC
  s.homepage         = 'https://github.com/GigabiteLabs/CometChatPro-UIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'GigabiteLabs' => 'engineering@gigabitelabs.com' }
  s.source           = { :git => 'https://github.com/GigabiteLabs/CometChatPro-UIKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gigabitelabs'
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.source_files = 'CometChatPro-UIKit/Classes/**/*'
  s.resource_bundles = {
      'CometChatPro-UIKit' => ['CometChatPro-UIKit/Assets/**/*.{plist,png,xcassets,xib,storyboard,strings,wav,otf}']
  }
  s.ios.frameworks = 'UIKit', 'QuartzCore', 'AVKit', 'AVFoundation', 'QuickLook', 'AudioToolbox', 'Foundation', 'Accelerate', 'CoreImage', 'CoreGraphics', 'WebKit'
  s.dependency 'CometChatPro', '2.0.12-Xcode11.4'
  s.dependency 'Firebase/Messaging'
  s.dependency 'SwiftyJSON'
  s.vendored_frameworks = '$(PODS_ROOT)/CometChatPro/CometChatPro.framework','$(PODS_ROOT)/CometChatPro/Vendors/JitsiMeet.framework','$(PODS_ROOT)/CometChatPro/Vendors/WebRTC.framework'
  s.pod_target_xcconfig = {
      'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/CometChatPro $(PODS_ROOT)/CometChatPro/Vendors',
      'OTHER_LDFLAGS'          => '$(inherited) -lObjC'
  }
  s.static_framework = true
end
