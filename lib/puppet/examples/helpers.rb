require 'puppet/examples/helpers/version'

module Puppet
  module Examples
    # A main module of puppet-examples-helpers
    module Helpers
      DEFAULT_MODULENAME = 'modulename'.freeze
      BASE_EXAMPLES_PATH = Pathname.new('examples')
      DEFAULT_INIT_FILENAME = 'init'.freeze

      # Reads an example mainifests from examples/ directory
      # This can be useful in puppet's acceptance tests
      # @return [String] The example file contents
      # @param [String] classname The file path to be read, in puppet loader convention
      def example(classname = nil)
        paths = normalize(classname).split('::')[1..-1]
        paths = [DEFAULT_INIT_FILENAME] if paths.empty?
        paths[-1] = "#{paths[-1]}.pp"

        path = BASE_EXAMPLES_PATH
        paths.each do |subpath|
          path = path.join(subpath)
        end
        raise "Can't read example manifest '#{path}'" unless path.readable?
        $stderr.puts "Reading example manifest '#{path}'"
        path.read
      end

      private

      def normalize(classname)
        classname ||= DEFAULT_MODULENAME
        classname.gsub!(/^::/, '') if classname =~ /^::/
        classname = DEFAULT_MODULENAME if classname.empty?
        classname
      end
    end
  end
end
