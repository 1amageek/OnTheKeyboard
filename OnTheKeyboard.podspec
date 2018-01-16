Pod::Spec.new do |s|

  s.name         = "OnTheKeyboard"
  s.version      = "0.0.2t"
  s.summary      = "Toolbar on the keyboard"
  s.description  = <<-DESC
OnTheKeyboard provides a toolbar located above the keyboard.
                   DESC

  s.homepage     = "https://github.com/1amageek/OnTheKeyboard"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "1amageek" => "tmy0x3@icloud.com" }
  s.social_media_url   = "http://twitter.com/1amageek"
  s.platform     = :ios, "10.0"
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/1amageek/OnTheKeyboard.git", :tag => "#{s.version}" }
  s.source_files  = "OnTheKeyboard", "OnTheKeyboard/**/*.swift"
  s.requires_arc = true
  s.dependency "Toolbar"

end
