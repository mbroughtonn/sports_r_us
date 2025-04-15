require "test_helper"

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get cart_items_create_url
    assert_response :success
  end

  test "should get destory" do
    get cart_items_destory_url
    assert_response :success
  end
end
