class PostcodeFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    ukpostcode = UKPostcode.parse(value || "")

    unless ukpostcode.valid?
      record.errors.add(attribute, "not recognised as a UK postcode")
    end
  end
end
