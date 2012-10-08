module Thincloud
  module Resque
    # Public: Thincloud Resque Engine
    class Engine < ::Rails::Engine
      attr_accessor :options

      config.thincloud        = ActiveSupport::OrderedOptions.new
      config.thincloud.resque = ActiveSupport::OrderedOptions.new

      # convenience method for engine options / configuration
      def options
        config.thincloud.resque
      end

      initializer "thincloud.resque.set_options" do |app|
        app_name  = app.class.name.deconstantize.underscore
        rails_env = ENV["RAILS_ENV"] || "development"
        url       = ENV["REDIS_URL"] || "unix:///tmp/redis.sock"
        username  = ENV["RESQUE_WEB_USERNAME"] || "thincloud-resque"
        password  = ENV["RESQUE_WEB_PASSWORD"] || "thincloud-resque"

        options.redis_url       ||= url
        options.redis_namespace ||= "resque:#{app_name}:#{rails_env}"
        options.redis_driver    ||= "ruby"
        options.web_username    ||= username
        options.web_password    ||= password
        options.mailer          = true if options.mailer.nil?
        options.mailer_excluded_environments ||= []
      end

      initializer "thincloud.resque.environment" do |app|
        require "redis"
        require "resque"

        ::Resque.redis = ::Redis.new({
          url:    options.redis_url,
          driver: options.redis_driver
        })

        ::Resque.redis.namespace = options.redis_namespace
      end

      initializer "thincloud.resque.server" do |app|
        require "resque/server"
        require "resque-cleaner"

        # # use http basic auth for resque-web
        ::Resque::Server.use ::Rack::Auth::Basic do |username, password|
          username = options.web_username
          password = options.web_password
        end

        ::Resque::Server.set :show_exceptions, true
      end

      initializer "thincloud.resque.mailer" do |app|
        excluded_envs = options.mailer_excluded_environments

        if options.mailer
          require "resque_mailer"

          ::Resque::Mailer.excluded_environments = excluded_envs

          ActionMailer::Base.send :include, ::Resque::Mailer
        end
      end

    end
  end
end
