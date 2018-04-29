require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do

  setup do
    @notes = FactoryBot.create_list(:note, 30)
    @note = @notes.first
  end

  test "GET Index" do
    get api_v1_notes_url
    assert_response :success
  end

  test "GET Show" do
    get api_v1_note_url(@note.id)
    assert_response :success
  end
end
