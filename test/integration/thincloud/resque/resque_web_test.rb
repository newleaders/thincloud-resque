require "minitest_helper"

module Thincloud
  module Resque
    class ResqueWebTest < MiniTest::Rails::ActionDispatch::IntegrationTest

      test "resque web available at /resque" do
        creds = ActionController::HttpAuthentication::Basic.encode_credentials(
          "thincloud-resque",
          "thincloud-resque"
        )

        get "/resque", nil, "HTTP_AUTHORIZATION" => creds

        assert_response :redirect
        assert_redirected_to "/resque/overview"
      end

    end
  end
end
