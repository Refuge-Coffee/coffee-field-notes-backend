class Api::V1::NoteResource < JSONAPI::Resource
  belongs_to :bean
  attributes :content, :created_at, :updated_at, :time_of_day
end
