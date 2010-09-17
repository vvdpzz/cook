require 'test_helper'

class TaggedControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get latest" do
    get :latest
    assert_response :success
  end

  test "should get active" do
    get :active
    assert_response :success
  end

  test "should get vote" do
    get :vote
    assert_response :success
  end

end
