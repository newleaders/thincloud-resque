require "minitest_helper"

module Thincloud
  module Resque
    class ResqueWebTest < MiniTest::Rails::ActionDispatch::IntegrationTest

      test "resque web available at /admin/resque" do
        creds = ActionController::HttpAuthentication::Basic.encode_credentials(
          "thincloud-resque",
          "thincloud-resque"
        )

        get "/admin/resque", nil, "HTTP_AUTHORIZATION" => creds

        assert_response :redirect
        assert_redirected_to "/admin/resque/overview"
      end

    end
  end
end
