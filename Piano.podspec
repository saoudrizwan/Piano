Pod::Spec.new do |s|
  s.name         = "Piano"
  s.version      = "1.1"
  s.summary      = "Compose a symphony of sounds and vibrations with Taptic Engine"
  s.description  = <<-DESC
    Piano is a delightful and easy-to-use wrapper around the AVFoundation and UIHapticFeedback classes, leveraging the full capabilities of the Taptic Engine, while following strict Apple guidelines to preserve battery life. Ultimately, Piano allows you, the composer, to conduct masterful symphonies of sounds and vibrations, and create a more immersive, usable and meaningful user experience in your app or game.
  DESC
  s.homepage     = "https://github.com/saoudrizwan/Piano"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Saoud Rizwan" => "hello@saoudmr.com" }
  s.social_media_url   = "https://twitter.com/sdrzn"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/saoudrizwan/Piano.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/**/*.{h,m,swift}"
end
