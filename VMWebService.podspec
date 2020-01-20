#
# Be sure to run `pod lib lint VMWebService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VMWebService'
  s.version          = '1.0.2'
  s.summary          = 'A general WebService architecture for iOS / Swift.'
  s.homepage         = 'https://github.com/vaneetmodgill@gmail.com/VMWebService'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Vaneet" => "vaneetmodgill@gmail.com" }
  
  spec.ios.deployment_target = "10.0"
   spec.swift_version = "4.2"
  
  s.source           = { :git => 'https://github.com/vaneetmodgill@gmail.com/VMWebService.git', :tag => s.version.to_s }

  s.source_files = 'VMWebService/Classes/**/*'
end
