# PuppetExamplesHelpers

[![Build Status](https://travis-ci.org/coi-gov-pl/puppet-examples-helpers.svg?branch=develop)](https://travis-ci.org/coi-gov-pl/puppet-examples-helpers) [![Gem](https://img.shields.io/gem/v/puppet-examples-helpers.svg)](https://rubygems.org/gems/puppet-examples-helpers)

Helpers to utilize puppet example files.

Using new `example` method you can read and execute example file provided in puppet modules in accetance tests.

```ruby
# Sets code to contents of examples/init.pp file
let(:code) { example '::modulename' }
```

## Installation

Add this to your puppet module's Gemfile:

```ruby
group :system_tests do
  # [..]
  gem 'puppet-examples-helpers'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puppet-examples-helpers

## Usage

### RSpec Acceptance Helper

```ruby
# file: spec/spec_helper_acceptance.rb
require 'puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'
require 'puppet-examples-helpers'

UNSUPPORTED_PLATFORMS = %w[Suse windows AIX Solaris].freeze

run_puppet_install_helper
install_module
install_module_dependencies

RSpec.configure do |c|
  c.include PuppetExamplesHelpers

  c.formatter = :documentation
end
```

### Acceptance Test Example

```ruby
# file: spec/acceptance/jboss/internal/service_spec.rb
require 'spec_helper_acceptance'

describe '::jboss::internal::service', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  # Reads examples/internal/service.pp file
  let(:code) { example '::jboss::internal::service' }

  it 'should work with no errors' do
    result = apply_manifest(code, catch_failures: true)
    expect(result.exit_code).to be(2)
  end
  it 'should work idempotently' do
    apply_manifest(code, catch_changes: true)
  end
  describe service('wildfly') do
    it { is_expected.to be_running }
  end
end
```

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bundle exec rake console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coi-gov-pl/puppet-examples-helpers. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [Apache 2.0](https://opensource.org/licenses/Apache-2.0).

## Code of Conduct

Everyone interacting in the Puppet::Examples::Helper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/coi-gov-pl/puppet-examples-helpers/blob/master/CODE_OF_CONDUCT.md).
