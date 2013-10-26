# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'n_adic_number/version'

Gem::Specification.new do |spec|
  spec.name          = "n_adic_number"
  spec.version       = NAdicNumber::VERSION
  spec.authors       = ["tsukasaoishi"]
  spec.email         = ["tsukasa.oishi@gmail.com"]
  spec.description   = %q{https://github.com/tsukasaoishi/n_adic_number}
  spec.summary       = %q{NAdicNumber treats N-adic Number}
  spec.homepage      = "https://github.com/tsukasaoishi/n_adic_number"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
