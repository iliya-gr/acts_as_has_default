$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_has_default/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_has_default"
  s.version     = ActsAsHasDefault::VERSION
  s.authors     = ["Iliya Grushevskiy"]
  s.email       = ["iliya.gr@gmail.com"]
  s.homepage    = "http://github.com/iliya-gr/acts_as_has_default"

  s.summary     = %q{A gem allowing active_record model has default value.}
  s.description = %q{This "acts_as" extension provides the capabilities for selecting default model according to scope.}

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'activerecord', '>= 3.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
end
