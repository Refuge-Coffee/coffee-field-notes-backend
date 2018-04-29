class Roaster < ApplicationRecord
  validates :name, presence: true
  has_many :locations
  has_many :beans
end
