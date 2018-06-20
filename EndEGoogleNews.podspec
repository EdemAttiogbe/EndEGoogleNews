# EndEGoogleNews.podspec
#
#

Pod::Spec.new do |s|
  s.name             = 'EndEGoogleNews'
  s.version          = '0.0.1'
  s.summary          = 'Easily create a valid Google News reqeust URL used to fetch news articles with the Google News RSS API.'

  s.description      = 'Easily create a valid Google News reqeust URL used to fetch news articles with the Google News RSS API.  Using this API, a proper Google News request URL is fully formed y simply adding items such as search terms, filters, and parameters'

  s.homepage         = 'https://github.com/EndEGroup/EndEGoogleNews'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EndEGroup' => 'edem.attiogbe@e-nd-e.com' }
  s.source           = { :git => 'https://github.com/EndEGroup/EndEGoogleNews.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'EndEGoogleNews/Classes/**/*'
end
