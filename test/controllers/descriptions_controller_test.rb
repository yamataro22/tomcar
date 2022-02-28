require "test_helper"

class DescriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get descriptions_new_url
    assert_response :success
  end

  test "should get update" do
    get descriptions_update_url
    assert_response :success
  end
end
