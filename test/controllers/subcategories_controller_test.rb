require "test_helper"

class SubcategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:adam)
    @subcategory = subcategories(:tyre18)
  end

  test "should redirect edit to login when not logged in" do
    get edit_subcategory_path(@subcategory)
    assert_redirected_to login_path
    assert_not flash.empty?
  end

end
