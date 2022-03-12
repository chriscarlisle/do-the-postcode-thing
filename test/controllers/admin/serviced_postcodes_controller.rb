# frozen_string_literal: true

require "test_helper"

class ServicedPostcodesControllerTest < ActionDispatch::IntegrationTest
  test "/admin redirects to admin_serviced_postcodes_path" do
    get "/admin"
    assert_redirected_to admin_serviced_postcodes_path
  end

  test "the page requires authentication" do
    get admin_serviced_postcodes_path
    assert_response :unauthorized

    get admin_serviced_postcodes_path, headers: basic_auth_header("admin", "password")
    assert_response :success
  end
end
