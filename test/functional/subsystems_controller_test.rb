# -*- encoding : utf-8 -*-
require 'test_helper'

class SubsystemsControllerTest < ActionController::TestCase
  setup do
    @subsystem = subsystems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subsystems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subsystem" do
    assert_difference('Subsystem.count') do
      post :create, subsystem: { id: @subsystem.id, name: @subsystem.name }
    end

    assert_redirected_to subsystem_path(assigns(:subsystem))
  end

  test "should show subsystem" do
    get :show, id: @subsystem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subsystem
    assert_response :success
  end

  test "should update subsystem" do
    put :update, id: @subsystem, subsystem: { id: @subsystem.id, name: @subsystem.name }
    assert_redirected_to subsystem_path(assigns(:subsystem))
  end

  test "should destroy subsystem" do
    assert_difference('Subsystem.count', -1) do
      delete :destroy, id: @subsystem
    end

    assert_redirected_to subsystems_path
  end
end
