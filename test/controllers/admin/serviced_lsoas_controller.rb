# frozen_string_literal: true

require "test_helper"

class ServicedLsoasControllerTest < ActionDispatch::IntegrationTest
  test "the page requires authentication" do
    get admin_serviced_lsoas_path
    assert_response :unauthorized

    get admin_serviced_lsoas_path, headers: basic_auth_header("admin", "password")
    assert_response :success
  end
end
