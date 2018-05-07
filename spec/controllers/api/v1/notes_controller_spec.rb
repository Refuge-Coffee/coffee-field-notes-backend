require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do

  setup do
    @notes = FactoryBot.create_list(:note, 30)
    @note = @notes.first
  end

  it "should GET Index" do
    get :index
    expect(response).to have_http_status(200)
  end

  it "should GET Show" do
    get :show, params: { id: @note.id }
    expect(response).to have_http_status(200)
  end
end
