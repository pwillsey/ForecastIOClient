Pod::Spec.new do |s|
  s.name             = "ForecastIOClient"
  s.version          = "0.1.0"
  s.summary          = "A Swift forecast.io API client."
  s.homepage         = "https://github.com/pwillsey/ForecastIOClient"
  s.license          = 'MIT'
  s.author           = { "Peter Willsey" => "pwillsey@gmail.com" }
  s.source           = { :git => "https://github.com/pwillsey/ForecastIOClient.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pwillsey'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ForecastIOClient' => ['Pod/Assets/*.png']
  }

  s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SwiftyJSON'
end
