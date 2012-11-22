module Thincloud
  module Resque
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield configuration if block_given?
      configuration
    end

    # Public: Configuration options for the Thincloud::Resque module
    class Configuration
      attr_accessor :redis_url
      attr_accessor :redis_namespace
      attr_accessor :redis_driver
      attr_accessor :web_username
      attr_accessor :web_password
      attr_accessor :mailer_environments

      def initialize
        url       = ENV["REDIS_URL"] || "unix:///tmp/redis.sock"
        username  = ENV["RESQUE_WEB_USERNAME"] || "thincloud-resque"
        password  = ENV["RESQUE_WEB_PASSWORD"] || "thincloud-resque"

        @redis_url       ||= url
        @redis_namespace ||= "resque"
        @redis_driver    ||= "ruby"
        @web_username    ||= username
        @web_password    ||= password
        @mailer_environments ||= [:production]
      end
    end
  end
end
