class PostcodeCheck
  class PostcodeCheckUnavailable < StandardError; end

  EXPLICITLY_SERVICED_POSTCODES = [
    "SH24 1AA",
    "SH24 1AB"
  ]

  SERVICED_LSOAS = [
    "Southwark",
    "Lambeth"
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
    postcodes_io = Postcodes::IO.new
    postcode = postcodes_io.lookup(@ukpostcode.to_s)

    return false unless postcode
    
    return postcode.lsoa.start_with? *SERVICED_LSOAS
  end
end
