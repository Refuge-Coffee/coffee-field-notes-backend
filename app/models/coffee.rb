class Coffee < ApplicationRecord
  validates :name, presence: true
  validates :origin, presence: true
  validates :elevation, presence: true
end
