# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "puppet/examples/helpers/version"

RVERSION = Gem::Version.new(RUBY_VERSION.dup)

def req(req_s)
  Gem::Requirement.new(req_s)
end

Gem::Specification.new do |spec|
  spec.name          = "puppet-examples-helpers"
  spec.version       = Puppet::Examples::Helpers::VERSION
  spec.authors       = ["Suszyński Krzysztof"]
  spec.email         = ["krzysztof.suszynski@coi.gov.pl"]

  spec.summary       = %q{Helpers to utilize puppet example files}
  spec.description   = 'Using new `example` method you can read and execute example file provided in' \
                       ' puppet modules in accetance tests.'
  spec.homepage      = "https://github.com/coi-gov-pl/puppet-examples-helpers"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rubocop", "~> 0.49" if req('>= 2.0') =~ RVERSION
end
