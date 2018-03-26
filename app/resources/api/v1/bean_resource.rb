class Api::V1::BeanResource < JSONAPI::Resource
  has_many :notes
  attributes :name, :origin, :elevation, :created_at, :updated_at
end
