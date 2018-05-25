#
# Be sure to run `pod lib lint MarSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MarSDK'
  s.version          = '0.0.4'
  s.summary          = 'A short description of MarSDK.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wanghuizhou21@163.com/MarSDK'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wanghuizhou21@163.com' => 'wanghuizhou@guazi.com' }
  s.source           = { :git => 'https://github.com/7General/MarSDK.git', :tag => s.version.to_s }


  s.ios.deployment_target = '8.0'

  s.source_files = 'MarSDK/Classes/**/*'
  #s.requires_arc = 'MarSDK/Classes/IMLonglink/**/**.*'
  
  s.libraries = 'z','resolv.9'
  s.frameworks = 'CoreTelephony','SystemConfiguration','CoreGraphics'
  s.vendored_frameworks = 'MarSDK/Frameworks/mars.framework'
  s.user_target_xcconfig =   {'OTHER_LDFLAGS' => ['-lc++']}
  
  
  s.dependency 'Protobuf'
end
