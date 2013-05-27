# -*- encoding : utf-8 -*-
require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { admin_equip: @user.admin_equip, admin_inv: @user.admin_inv, admin_user: @user.admin_user, assistant: @user.assistant, email: @user.email, last_login_at: @user.last_login_at, login: @user.login, login_count: @user.login_count, name: @user.name, responsible: @user.responsible }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { admin_equip: @user.admin_equip, admin_inv: @user.admin_inv, admin_user: @user.admin_user, assistant: @user.assistant, email: @user.email, last_login_at: @user.last_login_at, login: @user.login, login_count: @user.login_count, name: @user.name, responsible: @user.responsible }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
