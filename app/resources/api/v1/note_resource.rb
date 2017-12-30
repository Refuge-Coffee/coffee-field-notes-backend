class Api::V1::NoteResource < JSONAPI::Resource
  belongs_to :coffee
  attributes :content, :time_of_day
end
