require "test_helper"

class MainPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get main_pages_home_url
    assert_response :success
  end

  test "should get about" do
    get main_pages_about_url
    assert_response :success
  end

  test "should get help" do
    get main_pages_help_url
    assert_response :success
  end

  test "should get contact" do
    get main_pages_contact_url
    assert_response :success
  end

  test "non logged users should not see status path" do
    get main_pages_status_path
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test "logged in users should be able to see status path" do
    log_in_as(users(:adam))
    get main_pages_status_path
    assert_template 'main_pages/status'
    assert_response :success
  end
  
end
