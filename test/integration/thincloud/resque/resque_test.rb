require "minitest_helper"

module Thincloud
  module Resque

    describe "Resque Test" do
      let(:resque) { ::Resque }
      let(:config) { Dummy::Application.config.thincloud.resque }

      it { resque.redis.must_be_kind_of ::Redis::Namespace }
      it { resque.redis.namespace.must_equal config.redis_namespace }
    end

  end
end
