require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get nameabc" do
    get :nameabc
    assert_response :success
  end

  test "should get popular" do
    get :popular
    assert_response :success
  end

end
