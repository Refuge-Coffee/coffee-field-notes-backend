class Bean < ApplicationRecord
  validates :name, presence: true
  validates :origin, presence: true
  validates :elevation, presence: true

  has_many :notes

  belongs_to :roaster
end
