Pod::Spec.new do |s|
  s.name             = 'CometChatPro-UIKit'
  s.version          = '1.1.0'
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
  s.swift_version = '5.2'
  s.source_files = 'CometChatPro-UIKit/Classes/**/*'
  s.resource_bundles = {
      'CometChatPro-UIKit' => ['CometChatPro-UIKit/Assets/**/*.{plist,png,xcassets,xib,storyboard,strings,wav,otf}']
  }
  s.ios.frameworks = 'UIKit', 'QuartzCore', 'AVKit', 'AVFoundation', 'QuickLook', 'AudioToolbox', 'Foundation', 'Accelerate', 'CoreImage', 'CoreGraphics', 'WebKit', 'MobileCoreServices'
  s.dependency 'CometChatPro'
  s.dependency 'Firebase/Messaging'
  s.dependency 'SwiftyJSON'
  s.vendored_frameworks = '$(PODS_ROOT)/CometChatPro/CometChatPro.framework','$(PODS_ROOT)/CometChatPro/Vendors/JitsiMeet.framework','$(PODS_ROOT)/CometChatPro/Vendors/WebRTC.framework'
  s.pod_target_xcconfig = {
      'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/CometChatPro $(PODS_ROOT)/CometChatPro/Vendors',
      'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/FirebaseMessaging/FirebaseMessaging/Sources',
      'OTHER_LDFLAGS'          => '$(inherited) -lObjC'
  }
  s.static_framework = true
  # Adding tests with a swift dependency is a workaround in order to make pod lib lint work
  # See: https://github.com/CocoaPods/CocoaPods/issues/8649
  s.test_spec 'Tests' do |test_spec|
      test_spec.dependency 'Firebase/Messaging'
      test_spec.requires_app_host = true
      test_spec.source_files = 'Example/Tests/*.{swift}'
  end
end
