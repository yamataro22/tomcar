require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:adam)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "invalid@invalid.com",
                                          password: "password"}}
    
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_url
    assert flash.empty?
  end

  test "should change layout after successful login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,
                                          password: "password"}}
    
    assert_redirected_to root_url
    follow_redirect!

    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
  end

  test "after successful login logout should be successful as well" do
    log_in_as @user
    
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?

    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!

    assert_not flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end
end
