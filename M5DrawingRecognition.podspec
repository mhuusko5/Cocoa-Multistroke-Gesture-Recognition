Pod::Spec.new do |s|
  s.name = 'M5DrawingRecognition'
  s.version = '0.0.9'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Easily match multistroke drawings/gestures under iOS and OS X.'
  s.homepage = 'https://github.com/mhuusko5/M5DrawingRecognition'
  s.social_media_url = 'https://twitter.com/mhuusko5'
  s.authors = { 'Mathew Huusko V' => 'mhuusko5@gmail.com' }
  s.source = { :git => 'https://github.com/mhuusko5/M5DrawingRecognition.git', :tag => s.version.to_s }

  s.requires_arc = true

  s.osx.deployment_target = '10.8'
  s.ios.deployment_target = '7.0'
  
  s.osx.frameworks = 'Cocoa'
  s.ios.frameworks = 'UIKit'
  
  s.source_files = 'M5DrawingRecognition/*.h'
  s.exclude_files = 'M5DrawingRecognition/*Internal.h'
  
  s.subspec 'Internal' do |ss|
    ss.source_files = 'M5DrawingRecognition/*.h', 'M5DrawingRecognition/*.m'
    ss.private_header_files = 'M5DrawingRecognition/*Internal.h'
  end
end