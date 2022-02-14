require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup 
    @category = categories(:cars)
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "category name should not be empty" do
    @category.name = "   "
    assert_not @category.valid?
  end

  test "category name should have 20 chars at maximum" do
    @category.name = 'a' * 20
    assert @category.valid?

    @category.name = 'a' * 21
    assert_not @category.valid?
  end


end
