# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wak/version'

Gem::Specification.new do |spec|
  spec.name          = "wak"
  spec.version       = Wak::VERSION
  spec.authors       = ["Bob Van Landuyt"]
  spec.email         = ["bob@vanlanduyt.co"]
  spec.summary       = "Easy rack hosting in development"
  spec.description   = "Host rack apps in development using ngnix"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
