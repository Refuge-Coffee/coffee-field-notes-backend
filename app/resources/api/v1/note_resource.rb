class Api::V1::NoteResource < JSONAPI::Resource
  has_one :bean
  attributes :content, :created_at, :updated_at, :time_of_day
end
