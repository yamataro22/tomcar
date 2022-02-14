require "test_helper"

class SubcategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:adam)
    @category = categories(:cars)
    @subcategories = @category.subcategories
    @subcategory = @subcategories.first
  end

  test "user who is not logged in should not be able to see subcategories index" do
    get subcategories_path
    assert_redirected_to login_path
  end

  test "logged in user should be able to delete subcategories" do
    delete_category_text = "Usuń kategorię"

    log_in_as @user
    get categories_path
    
    assert_select 'a[href=?]', subcategory_path(@subcategories.first), 
                               text: delete_category_text, method: :delete 

    assert_select 'a[href=?]', subcategory_path(@subcategories.second), 
                               text: delete_category_text, method: :delete 

    assert_difference 'Subcategory.count', -1 do
      delete subcategory_path(@subcategory)
    end
    
    assert_redirected_to categories_path
    follow_redirect!
    assert_not flash.empty?

    assert_select 'a[href=?]', subcategory_path(@subcategory), 
                              text: delete_category_text, method: :delete, count: 0

    assert_select 'a[href=?]', subcategory_path(@subcategories.second), 
                              text: delete_category_text, method: :delete 
  end

  test "not logged user should not be able to delete subcategories" do 
    assert_no_difference 'Subcategory.count' do
      delete subcategory_path(@subcategory)
    end
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test "non logged users should be redirected to login when attempt of editing" do
    get edit_subcategory_path(@subcategory)
    assert_redirected_to login_path
  end

  test "non logged users should be redirected to login when attempt of updating" do
    post subcategories_path, params: { subcategory: { id: @subcategory.id,
                                                      name: "new name"}}
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test "successful edit" do
    log_in_as @user
    new_name = "Kaszana"

    post subcategories_path, params: { subcategory: { id: @subcategory.id,
                                                      name: new_name,
                                                      category: @category.name}}


    assert_redirected_to categories_path
    follow_redirect!
    assert_not flash.empty?

    assert_match new_name, response.body 
  end

end
