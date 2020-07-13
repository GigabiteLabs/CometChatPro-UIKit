#
# Be sure to run `pod lib lint CCPMessenger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CometChatProMessenger'
  s.version          = '0.1.1'
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
  s.osx.deployment_target  = '10.15'
  s.swift_version = '4.2'

  s.source_files = 'CCPMessenger/Classes/**/*'
  
  s.resource_bundles = {
      'CCPMessenger' => ['CCPMessenger/Assets/**/*.{plist,png,xcassets,xib,storyboard,strings,wav,otf}']
  }

  s.public_header_files = 'CCPMessenger/Classes/**/*.h'
  s.ios.frameworks = 'UIKit', 'QuartzCore', 'AVKit', 'AVFoundation', 'QuickLook', 'AudioToolbox', 'Foundation', 'Accelerate', 'CoreImage', 'CoreGraphics', 'WebKit'
  s.osx.framework  = 'AppKit'
  s.dependency 'CometChatPro', '2.0.12-Xcode11.4'
  s.dependency 'Firebase/Messaging'
  s.dependency 'SwiftyJSON'
end
