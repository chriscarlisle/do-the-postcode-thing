# post articles_url, params: { article: { body: 'Rails is awesome!', title: 'Hello Rails' } }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }

require "test_helper"

class ServicedLsoasControllerTest < ActionDispatch::IntegrationTest
  test "the page requires authentication" do
    get admin_serviced_lsoas_path
    assert_response :unauthorized

    get admin_serviced_lsoas_path, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("admin", "password") }
    assert_response :success
  end
end
