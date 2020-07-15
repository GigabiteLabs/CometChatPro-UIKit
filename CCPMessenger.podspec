Pod::Spec.new do |s|
  s.name             = 'CCPMessenger'
  s.version          = '0.2.0'
  s.summary          = 'A unified framework for CometChat Pro UIKit and binary framework.'
  s.description      = <<-DESC
'A framework for CometChat Pro that combines the CometChat Pro UIKit library and public binary framework.'
                       DESC
  s.homepage         = 'https://github.com/GigabiteLabs/CometChatProMessenger'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'GigabiteLabs' => 'engineering@gigabitelabs.com' }
  s.source           = { :git => 'https://github.com/GigabiteLabs/CometChatProMessenger.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gigabitelabs'
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.source_files = 'CCPMessenger/Classes/**/*'
  s.resource_bundles = {
      'CCPMessenger' => ['CCPMessenger/Assets/**/*.{plist,png,xcassets,xib,storyboard,strings,wav,otf}']
  }
  # s.public_header_files = 'CCPMessenger/Classes/**/*.h'
  s.ios.frameworks = 'UIKit', 'QuartzCore', 'AVKit', 'AVFoundation', 'QuickLook', 'AudioToolbox', 'Foundation', 'Accelerate', 'CoreImage', 'CoreGraphics', 'WebKit'
  s.static_framework = true
  # s.dependency 'CometChatPro', '2.0.12-Xcode11.4'
  # s.vendored_frameworks = 'CometChatPro.framework'
  #s.dependency 'Firebase/Messaging'
  s.dependency 'SwiftyJSON'
  # s.public_header_files = '$(PODS_ROOT)/CometChatPro/CometChatPro.framework/Headers/*.h'
  
  s.pod_target_xcconfig = {
     # 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/CometChatPro',
      #'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/GoogleMaps',
    'OTHER_LDFLAGS'          => '$(inherited) -lObjC'
  }
  
end
