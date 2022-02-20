require "test_helper"

class ProductsTest < ActionDispatch::IntegrationTest

  def setup
    log_in_as users(:adam)

    @polo   = products(:polo)
    @toyota = products(:peugeot)

    @subcategory = @polo.subcategory
  end

  test "new action should show category and subcategory" do
    get new_product_path(subcategory_id: @subcategory.id)
    assert_template 'products/new'
    assert_match @subcategory.name, response.body
    assert_match @subcategory.category.name, response.body
  end

  test "should pass subcategory id to create when first creation not successful" do
    get new_product_path(subcategory_id: @subcategory.id)
    assert request.params[:subcategory_id]

    assert_no_difference 'Product.count' do
      post products_path, params: { product: {name: "   ",
                                              subcategory_id: @subcategory.id}}
    end
    assert_select "div#error_explanation"

    assert_difference 'Product.count', 1 do
      post products_path, params: { product: {name: "name",
                                              short_description: "description",
                                              price: 123.0,
                                              subcategory_id: @subcategory.id}}
    end

    product = assigns(:product)
    assert_redirected_to product
    follow_redirect!
    assert_template 'products/show'
    assert_not flash.empty?
  end

end
