# frozen_string_literal: true

class PostcodeCheck
  class PostcodeCheckUnavailable < StandardError; end

  def initialize(postcode)
    @ukpostcode = UKPostcode.parse(postcode)
  end

  def serviced?
    return false unless valid_uk_postcode_format?

    explicitly_serviced? || serviced_by_lsoa?
  end

  private

  def valid_uk_postcode_format?
    @ukpostcode.valid?
  end

  def explicitly_serviced?
    ServicedPostcode.where(postcode: @ukpostcode.to_s).exists?
  end

  def serviced_by_lsoa?
    postcodes_io = Postcodes::IO.new
    postcode = postcodes_io.lookup(@ukpostcode.to_s)

    return false unless postcode

    postcode.lsoa.start_with?(*ServicedLsoa.pluck(:lsoa_prefix))
  rescue Excon::Error
    raise PostcodeCheckUnavailable
  end
end
