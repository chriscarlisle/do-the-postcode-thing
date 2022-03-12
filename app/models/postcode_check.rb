class PostcodeCheck
  class PostcodeCheckUnavailable < StandardError; end

  EXPLICITLY_SERVICED_POSTCODES = [
    "SH24 1AA",
    "SH24 1AB"
  ]

  def initialize(postcode)
    @ukpostcode = UKPostcode.parse(postcode)
  end

  def serviced?
    return false unless valid_uk_postcode_format?

    return explicitly_serviced_postcode?
  end

  private

  def valid_uk_postcode_format?
    @ukpostcode.valid?
  end

  def explicitly_serviced_postcode?
    EXPLICITLY_SERVICED_POSTCODES.include? @ukpostcode.to_s
  end
end
