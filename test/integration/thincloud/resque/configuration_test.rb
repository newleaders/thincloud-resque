require "minitest_helper"

module Thincloud
  module Resque

    describe "Configuration" do
      let(:config) { Dummy::Application.config.thincloud.resque }

      # defaults
      it { config.must_be_kind_of ActiveSupport::OrderedOptions }
      it { config.redis_url.must_equal "unix:///tmp/redis.sock" }
      it { config.web_username.must_equal "thincloud-resque" }
      it { config.web_password.must_equal "thincloud-resque" }
      it { config.mailer.must_equal true }
      it { config.mailer_excluded_environments.must_equal [] }

      # changed in dummy app environments/test.rb
      it { config.redis_namespace.must_equal "dummy_app_namespace" }
    end

  end
end
