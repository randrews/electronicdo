require 'test_helper'

class PilgrimsControllerTest < ActionController::TestCase
  setup do
    @pilgrim = pilgrims(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pilgrims)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pilgrim" do
    assert_difference('Pilgrim.count') do
      post :create, :pilgrim => @pilgrim.attributes
    end

    assert_redirected_to pilgrim_path(assigns(:pilgrim))
  end

  test "should show pilgrim" do
    get :show, :id => @pilgrim.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pilgrim.to_param
    assert_response :success
  end

  test "should update pilgrim" do
    put :update, :id => @pilgrim.to_param, :pilgrim => @pilgrim.attributes
    assert_redirected_to pilgrim_path(assigns(:pilgrim))
  end

  test "should destroy pilgrim" do
    assert_difference('Pilgrim.count', -1) do
      delete :destroy, :id => @pilgrim.to_param
    end

    assert_redirected_to pilgrims_path
  end
end
