require 'minitest_helper'

class ThincloudResqueTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Thincloud::Resque
  end
end
