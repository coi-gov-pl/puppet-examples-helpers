require 'spec_helper'

RSpec.describe Puppet::Examples::Helpers do
  describe '::VERSION' do
    let(:version) { Puppet::Examples::Helpers::VERSION }
    context 'as String' do
      subject { version }
      it { is_expected.not_to be nil }
      it { is_expected.to match(/^v?[0-9]+(.[0-9]+)*$/) }
    end
    context 'as Gem::Version' do
      let(:req) { Gem::Requirement.new('~> 0') }
      let(:gversion) { Gem::Version.new(version) }
      subject { req }
      it { is_expected.to be =~ gversion }
    end
  end

  describe '#example()' do
    include Puppet::Examples::Helpers

    def in_fake_stderr
      original_stderr = $stderr
      $stderr = StringIO.new
      yield
      $stderr.string
    ensure
      $stderr = original_stderr
    end

    subject { example examplefile }

    context 'given no parameter' do
      let(:examplefile) { nil }
      it { in_fake_stderr { is_expected.to eq("debug('an main init.pp')\n") } }
      it { expect { subject }.to output("Reading example manifest 'examples/init.pp'\n").to_stderr }
    end

    context 'given "::modulename"' do
      let(:examplefile) { '::modulename' }
      it { in_fake_stderr { is_expected.to eq("debug('an main init.pp')\n") } }
      it { expect { subject }.to output("Reading example manifest 'examples/init.pp'\n").to_stderr }
    end

    context 'given "::modulename::sub::showoff"' do
      let(:examplefile) { '::modulename::sub::showoff' }
      it { in_fake_stderr { is_expected.to eq("debug('just to show off')\n") } }
      it { expect { subject }.to output("Reading example manifest 'examples/sub/showoff.pp'\n").to_stderr }
    end

    context 'given "modulename::sample"' do
      let(:examplefile) { 'modulename::sample' }
      it { in_fake_stderr { is_expected.to eq("info('sample file')\n") } }
      it { expect { subject }.to output("Reading example manifest 'examples/sample.pp'\n").to_stderr }
    end
  end
end
