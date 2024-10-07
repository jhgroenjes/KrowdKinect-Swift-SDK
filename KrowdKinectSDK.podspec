Pod::Spec.new do |s|
  s.name         = "KrowdKinectSDK"
  s.version      = "0.3.3"
  s.summary      = "Full-screen Swift SDK for KrowdKinect client functionality."
  s.description  = <<-DESC
                   An SDK that presents all the features of KrowdKinect to any host app. KrowdKinect requires full screen in portrait mode.
                   DESC
  s.homepage     = "http://krowdkinect.com"
  s.license      = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author       = { "Jason Groenjes" => "jason@krowdkinect.com" }
  s.source       = { :git => "https://github.com/jhgroenjes/KrowdKinect-Swift-SDK.git", :tag => "#{s.version}" }
  s.platform     = :ios, "14.0"
  s.documentation_url       = "https://www.krowdkinect.com"
  s.swift_version           = '5.0'
  s.source_files = "Sources/**/*.{swift}"
  s.resources    = ["Sounds/*.mp3"]  # Include all .mp3 files in the Sounds folder
  s.requires_arc = true
  s.dependency 'Ably', '~> 1.2.33'
end

