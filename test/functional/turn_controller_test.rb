require 'test_helper'

class TurnControllerTest < ActionController::TestCase
  test "should get game_id:integer" do
    get :game_id:integer
    assert_response :success
  end

  test "should get pilgrim_id:integer" do
    get :pilgrim_id:integer
    assert_response :success
  end

  test "should get white_stones_drawn:integer" do
    get :white_stones_drawn:integer
    assert_response :success
  end

  test "should get black_stones_drawn:integer" do
    get :black_stones_drawn:integer
    assert_response :success
  end

  test "should get color_kept:integer" do
    get :color_kept:integer
    assert_response :success
  end

  test "should get pilgrim_rescued:integer" do
    get :pilgrim_rescued:integer
    assert_response :success
  end

  test "should get pilgrim_in_trouble:integer" do
    get :pilgrim_in_trouble:integer
    assert_response :success
  end

  test "should get goal_words_used:integer" do
    get :goal_words_used:integer
    assert_response :success
  end

  test "should get state:integer" do
    get :state:integer
    assert_response :success
  end

end
