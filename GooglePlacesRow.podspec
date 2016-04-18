Pod::Spec.new do |s|
  s.name             = "GooglePlacesRow"
  s.version          = "0.0.1"
  s.summary          = "A row extension for Eureka that allows the user to pick a place based on Google Places autocomplete feature"
  s.homepage         = "https://github.com/EurekaCommunity/GooglePlacesRow"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Mathias Claassen" => "mathias@xmartlabs.com" }
  s.source           = { git: "https://github.com/EurekaCommunity/GooglePlacesRow.git", tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/EurekaCommunity'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.dependency 'Eureka', '~> 1.5'
  s.libraries             = "c++", "icucore", "z" # required for GoogleMaps.framework
  s.frameworks            = "Accelerate", "AVFoundation", "CoreData", "CoreGraphics", "CoreBluetooth", "CoreLocation", "CoreText", "Foundation", "GLKit", "ImageIO", "OpenGLES", "QuartzCore", "SystemConfiguration", "GoogleMaps" # required for GoogleMaps.framework  
  s.vendored_frameworks = "Frameworks/GoogleMaps.framework"
  s.prepare_command = <<-CMD
                        curl -o GoogleMaps 'https://www.gstatic.com/cpdc/369280b0e1f04cb7-GoogleMaps-1.13.0.tar.gz'
                        tar -zxvf GoogleMaps
                   CMD
  #s.dependency 'GoogleMaps', '~> 1.13'
end
