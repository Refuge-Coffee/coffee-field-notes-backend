require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  setup do
    @locations = FactoryBot.create_list(:location, 15)
    @location = @locations.first
  end

  it "should GET Index" do
    get :index
    expect(response).to have_http_status(200)
  end

  it "should GET Show" do
    get :show, params: { id: @location.id }
    expect(response).to have_http_status(200)
  end
end
