# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'revealize/version'

Gem::Specification.new do |spec|
  spec.name          = "revealize"
  spec.version       = Revealize::VERSION
  spec.authors       = ["Rob Westgeest"]
  spec.email         = ["rob@qwan.it"]
  spec.description   = %q{A server and slide deck generator for revealjs}
  spec.summary       = %q{Utility for managing slide decks using revealjs
  revealize server serves slide decks 
  revealize build [slide deck] generates the slide deck given or all if slide deck ommitted}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rerun"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "capybara"
  spec.add_dependency "thor"
  spec.add_dependency "sinatra"
  spec.add_dependency "haml"
  spec.add_dependency "kramdown"
end
