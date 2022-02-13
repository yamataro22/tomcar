require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "adam@wp.pl", password: "dupa1234",
                     password_confirmation: "dupa1234")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email should not be empty" do 
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[foo@bar.com foo.bar@bar.com foo_bar-rab@rab.pl
                         foo@bar.rab.com foo-bar@rab.eu RAB@WP.PL]

    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[foo@bar,com foo.name@rab.
                           foo@bar_rab.com foo-bar@rab+eu foobar]

    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "users with different email should be accepted" do
    @user.save
    user2 = @user.dup
    user2.email = "another@example.com"
    assert @user.valid?
    assert user2.valid?
  end

  test "email should be unique" do
    @user.save
    user2 = @user.dup

    assert @user.valid?
    assert_not user2.valid?
  end

  test "email should be unique non-case sensitive" do
    @user.save
    user2 = @user.dup
    user2.email = @user.email.upcase

    assert @user.valid?
    assert_not user2.valid?
  end

  test "password should be as least 6 digits long" do
    @user.password = @user.password_confirmation =  "a" * 5
    assert_not @user.valid?
  end

end
