require 'rails_helper'

RSpec.describe Note, type: :model do

  setup do
    @note = FactoryBot.build(:note)
  end

  it "note factory builds a valid instance of Note" do
    expect(@note.valid?).to equal(true)
    expect(@note.save).to equal(true)
  end
end
