Pod::Spec.new do |s|
  s.name         = "KrowdKinectSDK"
  s.version      = "0.1.0"
  s.summary      = "Full-screen Swift SDK for KrowdKinect."
  s.description  = <<-DESC
                   An SDK that presents all the features of KrowdKinect to any host app. KrowdKinect requires full screen in portrait mode.
                   DESC
  s.homepage     = "http://krowdkinect.com"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Jason Groenjes" => "jason@krowdkinect.com" }
  s.source       = { :git => "https://github.com/jasongroenjes/KrowdKinect-Swift-SDK.git", :tag => "#{s.version}" }
  s.platform     = :ios, "14.0"
  s.source_files = "KrowdKinectSDK/**/*.{swift}"
  s.requires_arc = true
end

