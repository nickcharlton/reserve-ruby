# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reserve/version'

Gem::Specification.new do |spec|
  spec.name          = 'reserve'
  spec.version       = Reserve::VERSION
  spec.authors       = ['Nick Charlton']
  spec.email         = ['nick@nickcharlton.net']
  spec.summary       = %q{An object caching library for Redis.}
  spec.description   = %q{An object caching library for Redis.}
  spec.homepage      = 'https://github.com/nickcharlton/reserve-ruby'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'redis', '~> 3.1.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'mock_redis'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'yard'
end
