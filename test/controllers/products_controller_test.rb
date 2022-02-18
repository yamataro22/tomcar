require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:adam)
    @product = products(:polo)
  end

  test "should get products cataloque when logged in" do
    log_in_as @user
    get products_path
    assert_response :success
  end

  test "only logged-in users should see products cataloque" do
    get products_path
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "only logged-in users should be able to edit" do
    get edit_product_path(@product)
    assert_not flash.empty?
    assert_redirected_to login_path
    log_in_as @user
    get edit_product_path(@product)
    assert_template 'products/edit'
  end

end
