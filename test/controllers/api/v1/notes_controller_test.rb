require 'test_helper'

class Api::V1::NotesControllerTest < ActionDispatch::IntegrationTest

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
