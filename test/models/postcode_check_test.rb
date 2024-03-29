# frozen_string_literal: true

require "test_helper"

class PostcodeCheckTest < ActiveSupport::TestCase
  VALID_FORMAT_POSTCODES = {
    explicitly_serviced: [
      "SH24 1AA",
      "sh241ab",
    ],
    serviced_by_lsoa: [
      "SE1 7QD",
      "se17qa",
    ],
    not_serviced: [
      "LA2 6PR",
      "la26ps",
    ],
    not_in_postcode_io_db: [
      "TE37 1NG",
      "te371ng",
    ],
  }.freeze

  INVALID_FORMAT_POSTCODE = "Banana"

  test "serviced? returns false for postcodes in an invalid format" do
    assert !PostcodeCheck.new(INVALID_FORMAT_POSTCODE).serviced?
  end

  test "serviced? returns false for postcodes in a valid format, but aren't serviced" do
    VCR.use_cassette("not_serviced_by_lsoa") do
      VALID_FORMAT_POSTCODES[:not_serviced].each do |postcode|
        assert !PostcodeCheck.new(postcode).serviced?
      end
    end
  end

  test "serviced? returns false for postcodes in a valid format, but aren't in the postcode io database" do
    VCR.use_cassette("not_in_postcode_io_db") do
      VALID_FORMAT_POSTCODES[:not_in_postcode_io_db].each do |postcode|
        assert !PostcodeCheck.new(postcode).serviced?
      end
    end
  end

  test "serviced? returns true for explicitly serviced postcodes" do
    VALID_FORMAT_POSTCODES[:explicitly_serviced].each do |postcode|
      ServicedPostcode.new(postcode: postcode).save
      assert PostcodeCheck.new(postcode).serviced?
    end
  end

  test "serviced? returns true for postcodes serviced by lsoa" do
    ServicedLsoa.new(lsoa_prefix: "Southwark").save
    ServicedLsoa.new(lsoa_prefix: "Lambeth").save
    VCR.use_cassette("serviced_by_lsoa") do
      VALID_FORMAT_POSTCODES[:serviced_by_lsoa].each do |postcode|
        assert PostcodeCheck.new(postcode).serviced?
      end
    end
  end

  test "serviced? raises PostcodeCheckUnavailable if there is a network issue" do
    postcodes_io = Minitest::Mock.new
    def postcodes_io.lookup(*)
      raise Excon::Error
    end

    Postcodes::IO.stub :new, postcodes_io do
      VALID_FORMAT_POSTCODES[:serviced_by_lsoa].each do |postcode|
        assert_raises PostcodeCheck::PostcodeCheckUnavailable do
          PostcodeCheck.new(postcode).serviced?
        end
      end
    end
  end
end
