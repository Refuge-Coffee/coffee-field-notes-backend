class Api::V1::RoasterResource < JSONAPI::Resource
  has_many :locations
  has_many :beans
  attributes :name
end
