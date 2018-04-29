class Location < ApplicationRecord
  validates :name, :address, :rating, presence: true
  belongs_to :roaster
end
