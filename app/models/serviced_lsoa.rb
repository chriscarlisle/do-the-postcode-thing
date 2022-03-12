class ServicedLsoa < ApplicationRecord
  validates :lsoa_prefix, presence: true, uniqueness: true
end
