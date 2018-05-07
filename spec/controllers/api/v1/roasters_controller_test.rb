require 'rails_helper'

RSpec.describe Api::V1::RoastersController, type: :controller do
  setup do
    @roasters = FactoryBot.create_list(:roaster, 15)
    @roaster = @roasters.first
  end

  it "should GET Index" do
    get :index
    expect(response).to have_http_status(200)
  end

  it "should GET Show" do
    get :show, params: { id: @roaster.id }
    expect(response).to have_http_status(200)
  end
end
