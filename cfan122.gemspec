# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cfan122/version'

Gem::Specification.new do |spec|
  spec.name          = "cfan122"
  spec.version       = Cfan122::VERSION
  spec.authors       = ["cfanbase"]
  spec.email         = ["cfanbase@gmail.com"]

  spec.summary       = "A library for retrieving exam information from http://www.122.gov.cn"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/cfanbase/cfan122"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "jsonpath", "~> 0.5.8"
  spec.add_runtime_dependency "httparty", "~> 0.14"
  spec.add_runtime_dependency "activesupport", "~> 5.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
