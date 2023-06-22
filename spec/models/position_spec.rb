require 'rails_helper'

RSpec.describe Position, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name).with_message("can't be blank") }
    it { should validate_length_of(:name).is_at_least(4).with_message("is too short (minimum is 4 characters)") }
    it { should validate_length_of(:name).is_at_most(120).with_message("is too long (maximum is 120 characters)") }

    it { should validate_presence_of(:salary).with_message("can't be blank") }
    it { should validate_numericality_of(:salary).with_message("is not a number") }
    it { should validate_numericality_of(:salary).is_greater_than(0) }

    it { should validate_presence_of(:vacation_days).with_message("can't be blank") }

    it "validates that vacation_days is a number" do
      position = FactoryBot.build(:position, vacation_days: "test")
      position.valid?
      expect(position.errors[:vacation_days]).to include("is not a number")
    end
  end

  describe "associations" do
    it { should have_many(:position_histories).dependent(:destroy) }
    it { should have_many(:employees).through(:position_histories) }
  end

end
