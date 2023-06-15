require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name).with_message("can't be blank") }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(6).with_message("is too short (minimum is 6 characters)") }
    it { should validate_length_of(:name).is_at_most(120).with_message("is too long (maximum is 120 characters)") }

    it { should validate_presence_of(:abbreviation).with_message("can't be blank") }
    it { should validate_uniqueness_of(:abbreviation) }
    it { should validate_length_of(:abbreviation).is_at_least(40).with_message("is too short (minimum is 40 characters)") }
    it { should validate_length_of(:abbreviation).is_at_most(400).with_message("is too long (maximum is 400 characters)") }
  end

  describe 'associations' do
    it { should have_many(:employees).dependent(:destroy) }
  end
end
