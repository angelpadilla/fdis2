
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fdis/version"

Gem::Specification.new do |spec|
  spec.name          = "fdis"
  spec.version       = Fdis::VERSION
  spec.authors       = ["Angel Padilla"]
  spec.email         = ["angelpadillam@gmail.com"]

  spec.summary       = %q{Gem used to fetch the CFDIS Web API}
  spec.description   = %q{Gem used to fetch the CFDIS API for the mexican billing system (SAT).}
  spec.homepage      = "https://github.com/angelpadilla/fdis"
  spec.license       = "MIT"

  spec.metadata['allowed_push_host'] = "https://rubygems.org"
  spec.files         = ["README.md"] + Dir["lib/**/*.*"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.3.24"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "minitest", "~> 5.16.3"

  spec.add_dependency "nokogiri", "1.13.9"
end
