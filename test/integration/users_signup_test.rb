require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path

    assert_no_difference 'User.count' do
      post users_path, user: {name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"}
    end

    assert_template 'users/new'
    assert_select 'div.alert-danger'
    # not sure of syntax to write these:
    # page.must_have_content('Email is invalid')
    # assert 'Password is too short (minimum is 6 characters)'
  end

  test "valid signup information" do
    get signup_path

    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "Foo Bar",
          email: "user@example.com",
          password: "foobar",
          password_confirmation: "foobar"}
    end

    assert_template 'users/show'
    assert_select 'div.alert-success'
    assert_not flash.empty?
    # assert flash.('Welcome to the Sample App!')
  end
end
