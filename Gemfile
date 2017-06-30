source ENV['GEM_SOURCE'] || 'https://rubygems.org'

RVERSION = Gem::Version.new(RUBY_VERSION.dup)

def req(req_s)
  Gem::Requirement.new(req_s)
end

group :test do
  gem 'rspec', '~> 3',          require: false
  gem 'simplecov', '~> 0.14.1', require: false
  gem 'rubocop', '~> 0.49',     require: false if req('>= 2.0') =~ RVERSION
end

group :development do
  gem 'rake', '~> 10',                    require: false
  gem 'pry-byebug', '~> 3.4', '>= 3.4.2', require: false if req('>= 2.0') =~ RVERSION
end

# Specify your gem's dependencies in puppet-examples-helpers.gemspec
gemspec
