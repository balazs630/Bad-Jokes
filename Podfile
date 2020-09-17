# vim: syntax=ruby
## Global platform
platform :ios, '10.0'

## For dynamic frameworks
use_frameworks!

## Inhibit all warnings
inhibit_all_warnings!

## Set the workspace
workspace 'BadJokes.xcworkspace'

## Inject pods
target 'BadJokes' do
  pod 'FMDB', '~> 2.7.5'
end

## Remove the custom deployment targets from Pods
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
