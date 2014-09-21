# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weibo/auth_client/version'

Gem::Specification.new do |spec|
  spec.name          = "weibo-auth_client"
  spec.version       = Weibo::AuthClient::VERSION
  spec.authors       = ["Yuan Cheung"]
  spec.email         = ["zhangyuan@users.noreply.github.com"]
  spec.summary       = %q{Simple Weibo OAuth Client}
  spec.description   = %q{Simple Weibo OAuth Client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "multi_json", "~> 1.10"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "webmock", "~> 1.18"
  spec.add_development_dependency "rspec", "~> 3.0"
end
