# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retentiongrid/version'

Gem::Specification.new do |spec|
  spec.name          = "retentiongrid"
  spec.version       = Retentiongrid::VERSION
  spec.authors       = ["Christoph Bünte"]
  spec.email         = ["info@christophbuente.de"]
  spec.summary       = "A ruby client for retentiongrid.com API."
  spec.homepage      = "https://github.com/christoph-buente/retentiongrid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty', '0.13.1'
  spec.add_dependency 'activemodel', '>=3.2.0'


  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'factory_girl'

end
