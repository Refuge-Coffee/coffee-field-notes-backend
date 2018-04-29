require 'rails_helper'

RSpec.describe Note, type: :model do 

  setup do
    @note = FactoryBot.build(:note)
  end

  test "note factory builds a valid instance of Note" do
    assert @note.valid?
    assert_equal true, @note.save
  end
end
