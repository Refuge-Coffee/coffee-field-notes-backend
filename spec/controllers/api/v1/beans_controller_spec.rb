require 'rails_helper'

RSpec.describe Api::V1::BeansController, type: :controller do

  setup do
    @beans = FactoryBot.create_list(:bean, 30)
    @bean = @beans.first
  end

  test "GET Index" do
    get api_v1_beans_url
    assert_response :success
  end

  test "GET Show" do
    get api_v1_bean_url(@bean.id)
    assert_response :success
  end
end
