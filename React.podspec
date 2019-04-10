Pod::Spec.new do |s|

	# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
	s.name         = "React"
	s.version      = "0.1.0"
	s.summary      = "Mopinion iOS SDK React Native"
	s.ios.deployment_target  = '9.0'
	s.description  = "Mopinion mobile SDK for iOS React Native library"
	s.homepage     = "https://facebook.github.io/react-native/"
  
	# ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
	s.license      = { :type => "MIT", :file => "LICENSE" }
  
	# ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
	s.author      = "Facebook"
  
	# ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
	s.platform     = :ios, "9.0"
  
	# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
	s.source = {:git => "https://github.com/mopinion/mopinion-sdk-ios.git", :tag => s.version}
  
	# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
	s.ios.vendored_frameworks = 'React.framework'
  
  end
  