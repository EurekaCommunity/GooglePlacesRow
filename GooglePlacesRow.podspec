Pod::Spec.new do |s|
  s.name             = "GooglePlacesRow"
  s.version          = "3.2.0"
  s.summary          = "A row extension for Eureka that allows the user to pick a place based on Google Places autocomplete feature"
  s.homepage         = "https://github.com/EurekaCommunity/GooglePlacesRow"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Mathias Claassen" => "mathias@xmartlabs.com" }
  s.source           = { git: "https://github.com/EurekaCommunity/GooglePlacesRow.git", tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/EurekaCommunity'
  s.ios.deployment_target = '9.3'
  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.swift_version = '5.0'
  s.static_framework = true
  s.dependency 'Eureka' , '~> 5.0'
  s.dependency 'GooglePlaces' , '~> 3.7'
  s.dependency 'GoogleMaps/Base' , '~> 3.7'
  end
