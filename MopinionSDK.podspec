Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "MopinionSDK"
  s.version      = "0.4.5"
  s.summary      = "Mopinion iOS SDK"
  s.ios.deployment_target  = '9.0'
  s.description  = "Mopinion mobile SDK for iOS. Build dynamic customizable customer feedback forms for your iOS app."
  s.homepage     = "http://mopinion.com"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.authors      = { "Floris Snuif" => "floris@mopinion.com", "Anwar Jebali" => "anwar@mopinion.com", "Kees van Welsenis" => "kvwelsenis@mopinion.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "9.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source = {:git => "https://github.com/mopinion/mopinion-sdk-ios.git", :tag => s.version}

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.vendored_frameworks = 'MopinionSDK.xcframework'

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.resources = "MopinionSDK.xcframework/*/MopinionSDK.framework/main.jsbundle", "MopinionSDK.xcframework/**/*.ttf"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#  s.framework  = "MopinionSDK"

end
