require "rails"

module Thincloud
  module Resque
    # Public: Thincloud Resque Engine
    class Engine < ::Rails::Engine

      # convenience method for engine options / configuration
      def configuration
        Thincloud::Resque.configuration
      end

      # initialize the configuration so it is available during rails init
      ActiveSupport.on_load :before_configuration do
        app_name  = Rails.application.class.name.deconstantize.underscore
        rails_env = Rails.env || "development"

        unless config.respond_to? :thincloud
          config.thincloud = ActiveSupport::OrderedOptions.new
        end

        config.thincloud.resque ||= Thincloud::Resque.configure do |c|
          c.redis_namespace = "resque:#{app_name}:#{rails_env}"
        end
      end

      rake_tasks { require "resque/tasks" }

      initializer "thincloud.resque.environment" do
        require "redis"
        require "resque"

        ::Resque.redis = ::Redis.new({
          url:    configuration.redis_url,
          driver: configuration.redis_driver
        })

        ::Resque.redis.namespace = configuration.redis_namespace
      end

      initializer "thincloud.resque.server" do
        require "resque/server"
        require "resque-cleaner"

        # use http basic auth for resque-web
        ::Resque::Server.use ::Rack::Auth::Basic do |username, password|
          username == configuration.web_username &&
          password == configuration.web_password
        end

        ::Resque::Server.set :show_exceptions, true

        # set the Resque::Server sinatra app as the endpoint for this engine
        self.class.endpoint ::Resque::Server
      end

      initializer "thincloud.resque.mailer", after: "finisher_hook" do
        if configuration.mailer_environments.include?(Rails.env.to_sym)
          require "resque_mailer"

          # We manage the environments by only including Resque::Mailer for
          # explicit environments (#mailer_environments)
          ::Resque::Mailer.excluded_environments = []

          # Make sure that Resque::Mailer ends up at the correct place
          # in the inheritance chain
          ActiveSupport.on_load :action_mailer do
            def self.inherited(subclass)
              subclass.send :include, ::Resque::Mailer
              super
            end
          end

        end
      end

    end
  end
end
