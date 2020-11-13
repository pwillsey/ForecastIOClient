Pod::Spec.new do |s|
  s.name             = "ForecastIOClient"
  s.version          = "0.2.3"
  s.summary          = "A Swift forecast.io API client."
  s.homepage         = "https://github.com/pwillsey/ForecastIOClient"
  s.license          = 'MIT'
  s.author           = { "Peter Willsey" => "pwillsey@gmail.com" }
  s.source           = { :git => "https://github.com/pwillsey/ForecastIOClient.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pwillsey'
  s.swift_version    = '4.0'
  
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.dependency 'AFNetworking'
  s.dependency 'SwiftyJSON'
end
