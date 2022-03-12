class PostcodeCheck
  class PostcodeCheckUnavailable < StandardError; end

  EXPLICITLY_SERVICED_POSTCODES = [
    "SH24 1AA",
    "SH24 1AB"
  ]

  SERVICED_BY_LSOA_POSTCODES = [
    "SE1 7QD",
    "SE1 7QA"
  ]

  def initialize(postcode)
    @ukpostcode = UKPostcode.parse(postcode)
  end

  def serviced?
    return false unless valid_uk_postcode_format?

    return explicitly_serviced? || serviced_by_lsoa?
  end

  private

  def valid_uk_postcode_format?
    @ukpostcode.valid?
  end

  def explicitly_serviced?
    ServicedPostcode.where(postcode: @ukpostcode.to_s).exists?
  end
  
  def serviced_by_lsoa?
    SERVICED_BY_LSOA_POSTCODES.include? @ukpostcode.to_s
  end
end
