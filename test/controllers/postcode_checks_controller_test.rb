require "test_helper"

class PostcodeChecksControllerTest < ActionDispatch::IntegrationTest
  TEST_POSTCODE = "LA2 6PR"

  test "a serviced postcode gives a successful response" do
    postcode_check = Minitest::Mock.new
    def postcode_check.serviced?
      true
    end

    PostcodeCheck.stub :new, postcode_check do
      post postcode_checks_path, params: { postcode: TEST_POSTCODE } 

      assert_response :success
      assert_select "h3", /Yes!/
    end
  end

  test "an unserviced postcode gives an unsuccessful response" do
    postcode_check = Minitest::Mock.new
    def postcode_check.serviced?
      false
    end

    PostcodeCheck.stub :new, postcode_check do
      post postcode_checks_path, params: { postcode: TEST_POSTCODE } 

      assert_response :success
      assert_select "h3", /No!/
    end
  end

  test "an unavailable response is returned if the postcode can't be checked" do
    postcode_check = Minitest::Mock.new
    def postcode_check.serviced?
      raise PostcodeCheck::PostcodeCheckUnavailable
    end

    PostcodeCheck.stub :new, postcode_check do
      post postcode_checks_path, params: { postcode: TEST_POSTCODE } 

      assert_response :success
      assert_select "h3", /maybe?/
    end
  end
end
