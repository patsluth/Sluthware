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
    s.version          = '1.1.0'
    s.summary          = 'Sluthware shared framework'
    s.description      = 'Sluthware shared framework description'
    s.homepage         = 'https://sluthware.com'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'patsluth' => 'pat.sluth@gmail.com' }
    s.source           = { :git => 'https://github.com/patsluth/Sluthware.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/patsluth'

	s.swift_version = '5.0'

	s.ios.deployment_target = '10.0'
	s.osx.deployment_target = '10.11'
	
	s.requires_arc = true
	s.static_framework = true

	s.default_subspecs = 'Default'





	s.subspec 'Default' do |ss|
		ss.ios.frameworks = 'Foundation',
		'CoreFoundation',
		'CoreGraphics',
		'CoreLocation',
		'UIKit',
		'SystemConfiguration',
        'AVKit'
		
		ss.ios.dependency 'SnapKit'
		ss.ios.dependency 'RxSwift'
		ss.ios.dependency 'RxCocoa'
		ss.ios.dependency 'RxSwiftExt'
		ss.ios.dependency 'PromiseKit'
		ss.ios.dependency 'CancelForPromiseKit'
		ss.ios.dependency 'Kingfisher', '~> 5.9.0'
		ss.ios.dependency 'SwiftDate'

		ss.ios.resource = 'Sluthware/Resources/UIKit/**/*'

		ss.ios.source_files = 'Sluthware/Classes/*.swift',
		'Sluthware/Classes/Shared/**/*',
		'Sluthware/Classes/Foundation/**/*',
		'Sluthware/Classes/CoreGraphics/**/*',
		'Sluthware/Classes/CoreLocation/**/*',
		'Sluthware/Classes/UIKit/**/*',
		'Sluthware/Classes/Reachability/**/*',
		'Sluthware/Classes/PromiseKit/**/*',
		'Sluthware/Classes/RxSwift/**/*',
		'Sluthware/Classes/SwiftDate/**/*'



		ss.osx.frameworks = 'Foundation',
		'CoreFoundation',
		'CoreGraphics',
		'CoreLocation',
		'SystemConfiguration'

		ss.osx.source_files = 'Sluthware/Classes/*.swift',
		'Sluthware/Classes/Shared/**/*',
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
		'CoreFoundation'
#		'simd'

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
	
	
	
	
	
	s.subspec 'Firebase' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Firebase'
		ss.dependency 'Firebase/Core'
		ss.dependency 'Firebase/Auth'
		
		ss.source_files = 'Sluthware/Classes/Firebase/Auth/**/*'
	end
	
	
	
	
	
	s.subspec 'FirebaseFirestore' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Sluthware/Firebase'
		ss.dependency 'Firebase/Firestore'
		
		ss.source_files = 'Sluthware/Classes/Firebase/Firestore/**/*'
	end
	
	
	
	
	
	s.subspec 'FirebaseFunctions' do |ss|
		ss.dependency 'Sluthware/Default'
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
		ss.dependency 'Sluthware/Alamofire'

		ss.source_files = 'Sluthware/Classes/API/**/*'
	end
	
	
	
	
	
	s.subspec 'Alamofire' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Alamofire'
		ss.dependency 'CancelForPromiseKit/Alamofire'
		
		ss.source_files = 'Sluthware/Classes/Alamofire/**/*'
	end
	
	
	
	
	
	s.subspec 'R.swift' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'R.swift'
		ss.dependency 'SegueManager/R.swift'
		
		ss.source_files = 'Sluthware/Classes/R.swift/**/*'
	end
	
	
	
	
	
	s.subspec 'Eureka' do |ss|
		ss.dependency 'Sluthware/Default'
		ss.dependency 'Eureka'
		
		ss.source_files = 'Sluthware/Classes/Eureka/**/*'
	end





end
