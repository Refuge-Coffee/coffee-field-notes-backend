require 'rails_helper'

RSpec.describe Bean, type: :model do
  setup do
    @bean = FactoryBot.build(:bean)
  end

  it "note factory builds a valid instance of Note" do
    expect(@bean.valid?).to equal(true)
    expect(@bean.save).to equal(true)
  end
end
