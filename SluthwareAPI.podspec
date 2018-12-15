#
# Be sure to run `pod lib lint Sluthware.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SluthwareAPI'
    s.version          = '1.0.31'
    s.summary          = 'Sluthware shared framework'
    s.description      = 'Sluthware shared framework description'
    s.homepage         = 'https://sluthware.com'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'patsluth' => 'pat.sluth@gmail.com' }
    s.source           = { :git => 'https://patsluth@bitbucket.org/patsluth/sluthware.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/patsluth'

	s.swift_version = '4.2'
	
	s.ios.deployment_target = '9.0'
	s.osx.deployment_target = '10.11'





	s.dependency 'Alamofire'
	s.dependency 'PromiseKit'

	s.source_files = 'SluthwareAPI/Classes/API/**/*'
	




end
