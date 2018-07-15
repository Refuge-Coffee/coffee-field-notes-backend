require 'rails_helper'

RSpec.describe Api::V1::BeansController, type: :controller do

  context "INDEX without search" do 
    setup do
      @beans = FactoryBot.create_list(:bean, 5)
      @bean = @beans.first
    end

    it "should GET Index" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context "INDEX with search" do 
    setup do
      FactoryBot.create(:bean, name: "testing_1")
      FactoryBot.create(:bean, name: "testing_2")
      FactoryBot.create(:bean, name: "testing_3")
      FactoryBot.create(:bean, name: "testing_4")
      FactoryBot.create(:bean, name: "nope")
    end

    it "should return a response containing elements that regex match the search term" do
      get :index, params: {
        filter: {
          query: "testing"
        }
      }
      expect(response).to have_http_status(200)
      expect(response.body["data"].length).to equal 4
    end
  end

  

  it "should GET Show" do
    bean = FactoryBot.create(:bean)
    get :show, params: { id: bean.id }
    expect(response).to have_http_status(200)
  end
end
