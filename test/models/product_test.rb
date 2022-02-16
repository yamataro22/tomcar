require "test_helper"

class ProductTest < ActiveSupport::TestCase

  def setup 
    @polo = products(:polo)
  end

  test "should be valid" do
    assert @polo.valid?
  end

  test "short description should be max 120 chars long" do
    @polo.short_description = "a"*121
    assert_not @polo.valid?
    @polo.short_description = "a"*120
    assert @polo.valid?
  end

  test "name should not be empty" do
    @polo.name = "    "
    assert_not @polo.valid?
  end

  test "name should be 20 chars at maximum" do
    @polo.name = "a"*21
    assert_not @polo.valid?
    @polo.name = "a"*20
    assert @polo.valid?
  end

  test "short description should be present" do
    @polo.short_description = "    "
    assert_not @polo.valid?
  end

end
