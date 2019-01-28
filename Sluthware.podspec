#
# Be sure to run `pod lib lint Sluthware.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

# pod lib lint --sources='https://github.com/CocoaPods/Specs.git,https://github.com/ABTSoftware/PodSpecs.git' --verbose --fail-fast
Pod::Spec.new do |s|
    s.name             = 'Sluthware'
    s.version          = '1.0.31'
    s.summary          = 'Sluthware shared framework'
    s.description      = 'Sluthware shared framework description'
    s.homepage         = 'https://sluthware.com'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'patsluth' => 'pat.sluth@gmail.com' }
    s.source           = { :git => 'https://github.com/patsluth/Sluthware.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/patsluth'

	s.swift_version = '4.2'

	s.ios.deployment_target = '9.0'
	s.osx.deployment_target = '10.11'

	s.static_framework = true

	s.default_subspecs = 'Default'





	s.subspec 'Default' do |ss|
		ss.ios.frameworks = 'Foundation',
		'CoreFoundation',
		'CoreGraphics',
		'CoreLocation',
		'UIKit',
		'SystemConfiguration'

		ss.ios.resource = 'Sluthware/Resources/UIKit/**/*'

		ss.ios.source_files = 'Sluthware/Classes/Shared/**/*',
		'Sluthware/Classes/Foundation/**/*',
		'Sluthware/Classes/CoreGraphics/**/*',
		'Sluthware/Classes/CoreLocation/**/*',
		'Sluthware/Classes/UIKit/**/*',
		'Sluthware/Classes/Reachability/**/*'



		ss.osx.frameworks = 'Foundation',
		'CoreFoundation',
		'CoreGraphics',
		'CoreLocation',
		'SystemConfiguration'

		ss.osx.source_files = 'Sluthware/Classes/Shared/**/*',
		'Sluthware/Classes/Foundation/**/*',
		'Sluthware/Classes/CoreGraphics/**/*',
		'Sluthware/Classes/CoreLocation/**/*',
		'Sluthware/Classes/Reachability/**/*'
	end





	s.subspec 'CoreLocation' do |ss|
		ss.dependency 'Sluthware/Default'

		ss.frameworks = 'Foundation',
		'CoreFoundation',
		'CoreLocation'

		ss.ios.source_files = 'Sluthware/Classes/CoreLocation/**/*'
	end





	s.subspec 'simd' do |ss|
		ss.dependency 'Sluthware/Default'

		ss.frameworks = 'Foundation',
		'CoreFoundation',
		'simd'

		ss.ios.source_files = 'Sluthware/Classes/simd/**/*'
	end





	s.subspec 'SceneKit' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Sluthware/simd'

		ss.frameworks = 'Foundation',
		'CoreFoundation',
		'SceneKit'

		ss.ios.source_files = 'Sluthware/Classes/SceneKit/**/*'
	end





	s.subspec 'ARKit' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Sluthware/SceneKit'
		ss.dependency 'Sluthware/simd'

		ss.frameworks = 'Foundation',
		'CoreFoundation',
		'ARKit'

		ss.ios.source_files = 'Sluthware/Classes/ARKit/**/*'
	end





	s.subspec 'RxSwift' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'RxSwift'
		ss.dependency 'RxCocoa'
		ss.dependency 'RxSwiftExt'

		ss.ios.frameworks = 'UIKit'

		ss.source_files = 'Sluthware/Classes/RxSwift/**/*'
		ss.ios.source_files = 'Sluthware/Classes/RxSwift+iOS/**/*'
		ss.osx.source_files = 'Sluthware/Classes/RxSwift+macOS/**/*'
	end





	s.subspec 'PromiseKit' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'PromiseKit'

		ss.source_files = 'Sluthware/Classes/PromiseKit/**/*'
	end
	
	
	
	
	
	s.subspec 'Firebase' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Sluthware/RxSwift'
		ss.dependency 'Sluthware/PromiseKit'
		ss.dependency 'Firebase'
		ss.dependency 'Firebase/Core'
		ss.dependency 'Firebase/Auth'
		
		ss.source_files = 'Sluthware/Classes/Firebase/Auth/**/*'
	end
	
	
	
	
	
	s.subspec 'FirebaseFirestore' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Sluthware/RxSwift'
		ss.dependency 'Sluthware/PromiseKit'
		ss.dependency 'Sluthware/Firebase'
		ss.dependency 'Firebase/Firestore'
		
		ss.source_files = 'Sluthware/Classes/Firebase/Firestore/**/*'
	end
	
	
	
	
	
	s.subspec 'FirebaseFunctions' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Sluthware/PromiseKit'
		ss.dependency 'Firebase'
		ss.dependency 'Firebase/Core'
		ss.dependency 'Firebase/Functions'
		
		ss.source_files = 'Sluthware/Classes/Firebase/Functions/**/*'
	end





	# Add the following line to the Podfile
	# source 'https://github.com/ABTSoftware/PodSpecs.git'
	s.subspec 'SciChart' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.ios.dependency 'SciChart'

		ss.ios.source_files = 'Sluthware/Classes/SciChart/**/*'
	end





	s.subspec 'API' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Alamofire'
		ss.dependency 'PromiseKit'

		ss.source_files = 'Sluthware/Classes/API/**/*'
	end





end
