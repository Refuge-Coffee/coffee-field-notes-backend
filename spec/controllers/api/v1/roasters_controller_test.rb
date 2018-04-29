require 'rails_helper'

RSpec.describe Api::V1::RoastersController, type: :controller do
  setup do
    @roasters = FactoryBot.create_list(:roaster, 15)
    @roaster = @roasters.first
  end

  test "GET Index" do
    get api_v1_roasters_url
    assert_response :success
  end

  test "GET Show" do
    get api_v1_roaster_url(@roaster.id)
    assert_response :success
  end
end
