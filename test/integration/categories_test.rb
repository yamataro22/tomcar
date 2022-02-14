require "test_helper"

class CategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:adam)
    @category = categories(:cars)
    @second_category = categories(:tyres)
    @categories = [@category, @second_category]

    @subcategories = @category.subcategories

    @subcategory = @subcategories.first
  end

  test "should show categories and subcategories on index page" do 
    log_in_as @user
    get categories_path
    assert_template 'categories/index'

    @categories.each do |category|
      assert_match category.name, response.body
      category.subcategories.each do |sub|
        assert_match sub.name, response.body
      end
    end
  end

  test "user who is not logged in should not be able to see categories index" do
    get categories_path
    assert_redirected_to login_path
  end

  test "logged in user should be able to delete categories" do
    delete_category_text = "Usuń kategorię"

    log_in_as @user
    get categories_path
    
    assert_select 'a[href=?]', category_path(@category), 
                               text: delete_category_text, method: :delete 

    assert_select 'a[href=?]', subcategory_path(@category.subcategories.first), 
                               text: delete_category_text, method: :delete 

    assert_select 'a[href=?]', category_path(@second_category), 
                               text: delete_category_text, method: :delete 

    assert_difference 'Category.count', -1 do
      delete category_path(@category)
    end
    
    assert_redirected_to categories_path
    follow_redirect!
    assert_not flash.empty?

    assert_select 'a[href=?]', category_path(@category), 
                               text: delete_category_text, method: :delete, count: 0

    assert_select 'a[href=?]', subcategory_path(@subcategories.first), 
                               text: delete_category_text, method: :delete, count: 0


    assert_select 'a[href=?]', category_path(@second_category), 
                               text: delete_category_text, method: :delete 
  end

  test "not logged user should not be able to delete categories" do 
    assert_no_difference 'Category.count' do
      delete category_path(@category)
    end
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test "non logged users should be redirected to login when attempt of editing" do
    get edit_category_path(@category)
    assert_redirected_to login_path
  end

  test "non logged users should be redirected to login when attempt of updating" do
    post categories_path, params: { category: { id: @category.id,
                                                name: "new name"}}
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test "successful edit" do
    log_in_as @user
    new_name = "Kaszana"

    post categories_path, params: { category: { id: @category.id,
                                                name: new_name}}


    assert_redirected_to categories_path
    follow_redirect!
    assert_not flash.empty?

    assert_match new_name, response.body 
  end
end
