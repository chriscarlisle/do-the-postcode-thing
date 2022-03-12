# frozen_string_literal: true

require "test_helper"

class ServicedPostcodeTest < ActiveSupport::TestCase
  test "postcodes are normalized" do
    assert ServicedPostcode.new(postcode: "aa11aa").postcode == ServicedPostcode.new(postcode: "AA1 1AA").postcode
  end

  test "postcode presence is validated" do
    assert !ServicedPostcode.new.valid?
  end

  test "postcode uniqueness is validated" do
    ServicedPostcode.new(postcode: "AA1 1AA").save
    assert !ServicedPostcode.new(postcode: "AA1 1AA").valid?
  end

  test "postcode format is validated" do
    assert ServicedPostcode.new(postcode: "AA1 1AA").valid?
    assert !ServicedPostcode.new(postcode: "Banana").valid?
  end
end
