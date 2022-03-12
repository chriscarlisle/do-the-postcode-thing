require "test_helper"

class ServicedLsoaTest < ActiveSupport::TestCase

  test "lsoa_prefix presence is validated" do
    assert !ServicedLsoa.new.valid?
  end

  test "lsoa_prefix uniqueness is validated" do
    ServicedLsoa.new(lsoa_prefix: "Southwark").save
    ServicedLsoa.new(lsoa_prefix: "Lambeth").save
    assert !ServicedLsoa.new(lsoa_prefix: "Southwark").valid?
  end
end
