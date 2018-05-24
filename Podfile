platform :ios, '10.0'

use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

target "BMUNapp" do
	pod 'STTwitter'
	pod 'DateTools'
	pod 'AFNetworking'
	pod 'SDWebImage'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '3.0'
		end
	end
end
