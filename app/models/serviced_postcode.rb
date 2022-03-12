class ServicedPostcode < ApplicationRecord
  validates :postcode, presence: true, uniqueness: true, postcode_format: true
  
  def postcode=(str)
    super UKPostcode.parse(str || "").to_s
  end
end
