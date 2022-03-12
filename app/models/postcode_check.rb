class PostcodeCheck
  class PostcodeCheckUnavailable < StandardError; end

  def initialize(postcode)
    @ukpostcode = UKPostcode.parse(postcode)
  end

  def serviced?
    return valid_uk_postcode_format?
  end

  private

  def valid_uk_postcode_format?
    @ukpostcode.valid?
  end
end
