require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_path
    assert_response :success
  end

  # test "should get new" do
    # get products_new_path
    # assert_response :success
  # end

  # test "should get edit" do
    # get products_edit_url
    # assert_response :success
  # end
end
