# frozen_string_literal: true

class ServicedLsoa < ApplicationRecord
  validates :lsoa_prefix, presence: true, uniqueness: true
end
