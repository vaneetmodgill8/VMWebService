#
# Be sure to run `pod lib lint VMWebService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VMWebService'
  s.version          = '1.0.3'
  s.summary          = 'A general WebService architecture for iOS / Swift.'
  
  
  s.homepage         = 'https://github.com/vaneetmodgill8/VMWebService'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vaneet' => 'vaneetmodgill@gmail.com' }
  
  
  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'
  
  s.source           = { :git => 'https://github.com/vaneetmodgill8/VMWebService.git', :tag => "#{s.version}"}

  s.source_files = 'VMWebService/Classes/**/*.{h,m,swift}'
end
