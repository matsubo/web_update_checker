# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'web_update_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "web_update_checker"
  spec.version       = WebUpdateChecker::VERSION
  spec.authors       = ["Yuki Matsukura"]
  spec.email         = ["matsubokkuri@gmail.com"]
  spec.summary       = %q{Check the web page is changed comparing to the previous time.}
  spec.description   = %q{First time of execution, this library get the specifified URL and preserve the result. After the 2nd time, compare the current page contents and previous contents. }
  spec.homepage      = "http://github.com/matsubo/web_update_checker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "mail"
end
