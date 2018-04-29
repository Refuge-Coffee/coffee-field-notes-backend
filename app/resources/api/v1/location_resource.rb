class Api::V1::LocationResource < JSONAPI::Resource

  attributes :name, :address, :city, :state, :rating, :website

end
