

Pod::Spec.new do |s|
  s.name             = 'MARSDK'
  s.version          = '0.0.2'
  s.summary          = 'tencent WeChat For MARS'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/7General/MarSDK.git'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wanghuizhou21@163.com' => 'wanghuizhou21@163.com' }
  s.source           = { :git => 'https://github.com/7General/MarSDK.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '8.0'

  s.source_files = 'MARSDK/Classes/**/*'
  
  #Mars库配置
  s.vendored_frameworks  = 'MARSDK/Framework/mars.framework'
  s.libraries = 'z','resolv.9'
  s.frameworks = 'CoreTelephony','SystemConfiguration','CoreGraphics'
  s.user_target_xcconfig =   {'OTHER_LDFLAGS' => ['-lc++']}
  
  s.requires_arc = 'MARSDK/Classes/Arc/**/*'
  
  s.public_header_files = 'MARSDK/Classes/**/*.h'
  
  s.dependency 'Protobuf'
  
  
  
  
end
