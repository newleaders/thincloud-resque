# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "thincloud/resque/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "thincloud-resque"
  s.version     = Thincloud::Resque::VERSION
  s.authors     = ["Don Morrison"]
  s.email       = ["dmorrison@newleaders.com"]
  s.homepage    = "http://newleaders.github.com/thincloud-resque"
  s.summary     = "Rails Engine to provide resque services for Thincloud applications"
  s.description = "Thincloud Resque is an extraction of the New Leaders resque recipes packaged up as a Rails engine to manage dependencies and configuration."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "redis", "~> 3.0.4"
  s.add_dependency "resque", "~> 1.25.1"
  s.add_dependency "resque-cleaner", "~> 0.2.11"
  s.add_dependency "resque_mailer", "~> 2.2.4"
  s.add_dependency "hiredis", "~> 0.4.5"

  s.add_development_dependency "thincloud-test"
end
