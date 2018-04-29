require 'test_helper'

class Api::V1::LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roasters = FactoryBot.create_list(:location, 15)
    @roaster = @locations.first
  end

  test "GET Index" do
    get api_v1_locations_url
    assert_response :success
  end

  test "GET Show" do
    get api_v1_location_url(@location.id)
    assert_response :success
  end
end
