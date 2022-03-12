# post articles_url, params: { article: { body: 'Rails is awesome!', title: 'Hello Rails' } }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }

require "test_helper"

class ServicedPostcodesControllerTest < ActionDispatch::IntegrationTest
  test "/admin redirects to admin_serviced_postcodes_path" do
    get "/admin"
    assert_redirected_to admin_serviced_postcodes_path
  end

  test "the page requires authentication" do
    get admin_serviced_postcodes_path
    assert_response :unauthorized

    get admin_serviced_postcodes_path, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("admin", "password") }
    assert_response :success
  end
end
