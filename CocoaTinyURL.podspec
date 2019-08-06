Pod::Spec.new do |s|
  s.name         = "CocoaTinyURL"
  s.version      = "1.0.0"
  s.homepage     = "https://github.com/leshkoapps/CocoaTinyURL"
  s.license      = 'MIT'
  s.author       = { "Artem" => "support@everappz.com" }
  s.source       = { :git => "https://github.com/leshkoapps/CocoaTinyURL.git", :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = '*.{h,m}'
  s.requires_arc = true
  s.framework = 'Foundation'
end
