

Pod::Spec.new do |s|


  s.name         = "TYCountLabel"
  s.version      = "0.0.1"
  s.summary      = "A simple count down Label"

  s.description  = "A simple countdown Label.Created by wangtaiyi"
  s.homepage     = "https://github.com/pridewty"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "wangtaiyi" => "pridewty@163.com" }
  s.source       = { :git => "https://github.com/pridewty/TYCountLabel.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TYCountLabel/**/*'



  # s.resource_bundles = {
  #   'TYCountLabel' => ['TYCountLabel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

end
