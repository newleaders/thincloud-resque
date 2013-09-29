source "https://rubygems.org"

# Declare your gem's dependencies in thincloud-resque.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

platforms :jruby do
  gem "activerecord-jdbc-adapter", :require => false
end

group :test do
  platforms :ruby do
    gem "hiredis", "~> 0.4.5"
    gem "sqlite3"
  end

  platforms :jruby do
    gem "activerecord-jdbcsqlite3-adapter", :require => false
  end
end
