require 'rails_helper'

RSpec.describe Api::V1::BeansController, type: :controller do

  setup do
    @beans = FactoryBot.create_list(:bean, 30)
    @bean = @beans.first
  end

  it "should GET Index" do
    get :index
    expect(response).to have_http_status(200)
  end

  it "should GET Show" do
    get :show, params: { id: @bean.id }
    expect(response).to have_http_status(200)
  end
end
