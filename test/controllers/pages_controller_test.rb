require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_index_url
    assert_response :success
  end

  test "should get privacy_terms" do
    get pages_privacy_terms_url
    assert_response :success
  end
end
