require "test_helper"

class SubcategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:adam)
    @subcategories = subcategories
  end

  test "should show subcategories on index page" do 
    log_in_as @user
    get subcategories_path
    assert_template 'subcategories/index'

    @subcategories.each do |subcategory|
      assert_match subcategory.name, response.body
    end
  end

  test "user who is not logged in should not be able to see subcategories index" do
    get subcategories_path
    assert_redirected_to login_path
  end

  test "logged in user should be able to delete users" do
    delete_category_text = "Usuń kategorię"

    log_in_as @user
    get subcategories_path
    
    assert_select 'a[href=?]', subcategory_path(subcategories(:tyres)), 
                              text: delete_category_text, method: :delete 

    assert_select 'a[href=?]', subcategory_path(subcategories(:cars)), 
                              text: delete_category_text, method: :delete 

    assert_difference 'Subcategory.count', -1 do
      delete subcategory_path(subcategories(:cars))
    end
    
    assert_redirected_to subcategories_path
    follow_redirect!
    assert_not flash.empty?

    assert_select 'a[href=?]', subcategory_path(subcategories(:cars)), 
                              text: delete_category_text, method: :delete, count: 0

    assert_select 'a[href=?]', subcategory_path(subcategories(:tyres)), 
                              text: delete_category_text, method: :delete 
  end

  test "not logged user should not be able to delete subcategories" do 
    assert_no_difference 'Subcategory.count' do
      delete subcategory_path(subcategories(:cars))
    end
    assert_redirected_to login_path
    assert_not flash.empty?
  end

end
