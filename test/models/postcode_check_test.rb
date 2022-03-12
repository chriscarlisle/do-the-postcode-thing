require "test_helper"

class PostcodeCheckTest < ActiveSupport::TestCase
  VALID_FORMAT_POSTCODES = [
    "SE1 7QD",
    "SE17QA",
    "sh24 1aa",
    "sh241aa"
  ]

  INVALID_FORMAT_POSTCODE = "Banana"

  test "serviced? returns true for postcodes in a valid format" do
    VALID_FORMAT_POSTCODES.each do |postcode|
      assert PostcodeCheck.new(postcode).serviced?
    end
  end

  test "serviced? returns false for postcodes in an invalid format" do
    assert !PostcodeCheck.new(INVALID_FORMAT_POSTCODE).serviced?
  end
end
