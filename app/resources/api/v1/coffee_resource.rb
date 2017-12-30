class Api::V1::CoffeeResource < JSONAPI::Resource
  has_many :notes
  attributes :name, :origin, :elevation
end
