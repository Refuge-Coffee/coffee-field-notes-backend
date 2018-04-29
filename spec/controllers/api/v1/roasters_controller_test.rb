require 'rails_helper'

class Api::V1::RoastersControllerTest < ActionDispatch::IntegrationTest
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
