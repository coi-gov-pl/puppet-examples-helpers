# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet-examples-helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'puppet-examples-helpers'
  spec.version       = PuppetExamplesHelpers::VERSION
  spec.authors       = ['Suszyński Krzysztof']
  spec.email         = ['krzysztof.suszynski@coi.gov.pl']

  spec.summary       = 'Helpers to utilize puppet example files'
  spec.description   = 'Using new `example` method you can read and execute example file provided in' \
                       ' puppet modules in accetance tests.'
  spec.homepage      = 'https://github.com/coi-gov-pl/puppet-examples-helpers'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.0'

  spec.add_development_dependency 'bundler', '~> 1.15'
end
