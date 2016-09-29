Pod::Spec.new do |s|
  s.name             = "GooglePlacesRow"
  s.version          = "1.0.1"
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
  s.dependency 'Eureka' , '~> 2.0.0-beta.1'
  s.libraries             = "c++", "icucore", "z" # required for GoogleMaps.framework
  s.frameworks            = "Accelerate", "AVFoundation", "CoreData", "CoreGraphics", "CoreBluetooth", "CoreLocation", "CoreText", "Foundation", "GLKit", "ImageIO", "OpenGLES", "QuartzCore", "SystemConfiguration", "GoogleMapsBase", "GooglePlaces" # required for GooglePlaces.framework  
  s.vendored_frameworks = "Frameworks/GoogleMapsBase.framework", "Frameworks/GooglePlaces.framework"
  s.prepare_command = <<-CMD
                        curl -o GoogleMaps 'https://www.gstatic.com/cpdc/5a212b0fa429156f-GoogleMaps-2.0.1.tar.gz'
                        tar -zxvf GoogleMaps
                        curl -o GooglePlaces 'https://www.gstatic.com/cpdc/2b9e8b99fc05d124-GooglePlaces-2.0.1.tar.gz'
                        tar -zxvf GooglePlaces
                   CMD
  #s.dependency 'GoogleMaps', '~> 2.0.1'
  #s.dependency 'GooglePlaces', '~> 2.0.1'
end
