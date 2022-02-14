require "test_helper"

class SubcategoryTest < ActiveSupport::TestCase

  def setup 
    @subcategory = Subcategory.new(name: "Description")
  end

  test "should be valid" do
    assert @subcategory.valid?
  end

  test "subcategory name should not be empty" do
    @subcategory.name = "   "
    assert_not @subcategory.valid?
  end

  test "subcategory name should have 20 chars at maximum" do
    @subcategory.name = 'a' * 20
    assert @subcategory.valid?

    @subcategory.name = 'a' * 21
    assert_not @subcategory.valid?
  end
end
