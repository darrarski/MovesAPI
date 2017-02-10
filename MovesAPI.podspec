Pod::Spec.new do |s|
  s.name                  = 'MovesAPI'
  s.version               = '0.1.0'
  s.summary               = 'Unofficial Moves API client written in Swift.'
  s.homepage              = 'https://github.com/darrarski/MovesAPI'
  s.author                = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.social_media_url      = 'https://twitter.com/darrarski'
  s.license               = { :type => 'MIT', 
                              :file => 'LICENSE' }
  s.source                = { :git => 'https://github.com/darrarski/MovesAPI.git', 
                              :tag => "#{s.version}" }
  s.platform              = :ios
  s.ios.deployment_target = '10.0'
  s.source_files          = 'MovesAPI/**/*.swift'
  s.requires_arc          = true
  s.dependency            'RxSwift', '~> 3.0'
  s.dependency            'ModelMapper', '~> 5.0'
  s.dependency            'Alamofire', '~> 4.0'
  s.dependency            'RxAlamofire', '~> 3.0'
end
