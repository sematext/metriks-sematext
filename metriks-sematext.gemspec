# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metriks/sematext/version'

Gem::Specification.new do |spec|
  spec.name          = "metriks-sematext"
  spec.version       = Metriks::Sematext::VERSION
  spec.authors       = ["Pavel Zalunin"]
  spec.email         = ["info@sematext.com"]
  spec.description   = %q{Metriks reporter for sending Custom Metrics to SPM for graphing}
  spec.summary       = %q{Metriks reporter for SPM}
  spec.homepage      = "https://github.com/sematext/metriks-sematext"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha", "~> 0.10"

  spec.add_runtime_dependency "metriks", "~> 0.9.9.4"
  spec.add_runtime_dependency "sematext-metrics", "~> 0.0.1.1"
end
