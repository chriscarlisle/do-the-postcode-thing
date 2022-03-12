require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "the page shows the postcode search form" do
    get root_url

    assert_response :success
    assert_select "form input[name=postcode]"
    assert_select "form input[type=submit]"
  end
end
