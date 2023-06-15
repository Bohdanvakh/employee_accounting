require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(6).is_at_most(120) }

    it { should validate_presence_of(:abbreviation) }
    it { should validate_uniqueness_of(:abbreviation) }
    it { should validate_length_of(:abbreviation).is_at_least(40).is_at_most(400) }
  end

  describe 'associations' do
    it { should have_many(:employees).dependent(:destroy) }
  end
end
