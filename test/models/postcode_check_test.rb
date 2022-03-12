require "test_helper"

class PostcodeCheckTest < ActiveSupport::TestCase
  VALID_FORMAT_POSTCODES = {
    explicitly_serviced: [
      "SH24 1AA",
      "sh241ab"
    ],
    serviced_by_lsoa: [
      "SE1 7QD",
      "se17qa",
    ],
    not_serviced: [
      "LA2 6PR",
      "la26ps",
    ],
  }

  INVALID_FORMAT_POSTCODE = "Banana"

  test "serviced? returns false for postcodes in an invalid format" do
    assert !PostcodeCheck.new(INVALID_FORMAT_POSTCODE).serviced?
  end

  test "serviced? returns false for postcodes in a valid format, but aren't serviced" do
    VALID_FORMAT_POSTCODES[:not_serviced].each do |postcode|
      assert !PostcodeCheck.new(postcode).serviced?
    end
  end

  test "serviced? returns true for explicitly serviced postcodes" do
    VALID_FORMAT_POSTCODES[:explicitly_serviced].each do |postcode|
      ServicedPostcode.new(postcode: postcode).save
      assert PostcodeCheck.new(postcode).serviced?
    end
  end

  test "serviced? returns true for postcodes serviced by lsoa" do
    VALID_FORMAT_POSTCODES[:serviced_by_lsoa].each do |postcode|
      assert PostcodeCheck.new(postcode).serviced?
    end
  end

end
