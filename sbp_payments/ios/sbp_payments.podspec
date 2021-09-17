#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint sbp_payments.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'sbp_payments'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin which helps to handle sbp payment links and open it with specific bank app'
  s.description      = <<-DESC
Flutter plugin which helps to handle sbp payment links and open it with specific bank app
                       DESC
  s.homepage         = 'https://github.com/MrOlolo/sbp_payments/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'MrOlolo' => 'mr.kostman@gmail.com' }
  s.source           = { :path => '.'}
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.dependency 'SBPWidget'
end
