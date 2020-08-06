#
# Be sure to run `pod lib lint AlamofireEasyLogger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AlamofireEasyLogger'
  s.version          = '1.5.0'
  s.summary          = 'Easy drop-in Alamofire request & response logger.'
  s.swift_version    = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Easy drop-in Alamofire request & response logger.
No configuration is needed, it just works.
Works for all requests and responses. There is no need to call a function on every request.
Provides a full request/response logger out of the box and allows for easy overriding in case you have different requirements for what you want to see.
                       DESC

  s.homepage         = 'https://github.com/jankaltoun/AlamofireEasyLogger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jankaltoun' => 'jan.kaltoun@me.com' }
  s.source           = { :git => 'https://github.com/jankaltoun/AlamofireEasyLogger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'AlamofireEasyLogger/Classes/**/*'
  
  s.dependency 'Alamofire', '>= 5.0'
end
