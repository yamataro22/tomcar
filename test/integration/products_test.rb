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

end
