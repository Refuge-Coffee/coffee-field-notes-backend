require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  setup do
    @note = FactoryBot.build(:note)
  end

  test "note factory builds a valid instance of Note" do
    assert @note.valid?
    assert_equal true, @note.save
  end
end
