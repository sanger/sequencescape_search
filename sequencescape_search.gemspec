# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sequencescape_search/version'

Gem::Specification.new do |spec|
  spec.name          = "sequencescape_search"
  spec.version       = SequencescapeSearch::VERSION
  spec.authors       = ["James Glover"]
  spec.email         = ["james.glover@sanger.ac.uk"]
  spec.description   = %q{Simple wrapper for Sequencescape Searches}
  spec.summary       = %q{Simple wrapper for Sequencescape Searches}
  spec.homepage      = "http://www.github.com/sanger"
  spec.license       = "GNU"

  spec.required_ruby_version = '>= 2.3.0'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end


