# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geolookup/version'

Gem::Specification.new do |spec|
  spec.name          = "geolookup"
  spec.version       = Geolookup::VERSION
  spec.authors       = ["Austin Fonacier", "David Butler", "Jeffrey Lee", "Wei Yan", "Kyle Boss"]
  spec.email         = ["austin@spokeo.com", "dwbutler@ucla.edu", "jlee@spokeo.com", "wyan@spokeo.com", "kboss@spokeo.com"]
  spec.summary       = "Common geo lookups"
  spec.description   = "Common geo lookups"
  spec.homepage      = "https://github.com/spokeo/geolookup"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "gem_versioner"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
