require "test_helper"

class SubcategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:adam)
  end

  test "should get index when logged in" do
    log_in_as @user
    get subcategories_index_url
    assert_response :success
  end

  test "should redirect to login when not logged in" do
    get subcategories_index_url
    assert_redirected_to login_path
    assert_not flash.empty?
  end

end
