require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "validations" do
    it { should validate_presence_of(:last_name).with_message("can't be blank") }
    it { should validate_length_of(:last_name).is_at_least(2).with_message("is too short (minimum is 2 characters)") }
    it { should validate_length_of(:last_name).is_at_most(30).with_message("is too long (maximum is 30 characters)") }

    it { should validate_presence_of(:first_name).with_message("can't be blank") }
    it { should validate_length_of(:first_name).is_at_least(2).with_message("is too short (minimum is 2 characters)") }
    it { should validate_length_of(:first_name).is_at_most(30).with_message("is too long (maximum is 30 characters)") }

    it { should validate_presence_of(:middle_name).with_message("can't be blank") }
    it { should validate_length_of(:middle_name).is_at_least(2).with_message("is too short (minimum is 2 characters)") }
    it { should validate_length_of(:middle_name).is_at_most(30).with_message("is too long (maximum is 30 characters)") }

    it { should validate_presence_of(:passport_data).with_message("can't be blank") }
    it { should validate_length_of(:passport_data).is_equal_to(9).with_message("is the wrong length (should be 9 characters)") }

    it { should validate_presence_of(:date_of_birth).with_message("can't be blank") }

    it { should validate_presence_of(:place_of_birth).with_message("can't be blank") }
    it { should allow_value("Los Angeles").for(:place_of_birth) }
    it { should_not allow_value("12345").for(:place_of_birth).with_message("is invalid") }

    it { should validate_presence_of(:home_address).with_message("can't be blank") }
    it { should allow_value("123 Los Angeles").for(:home_address) }
    it { should_not allow_value("Los Angeles").for(:home_address).with_message("is invalid") }


    it 'validates date_of_birth before 18 years ago' do
      employee = FactoryBot.build(:employee, date_of_birth: Date.today - 10.years)
      expect(employee).not_to be_valid
      expect(employee.errors[:date_of_birth]).to include("must be before 18 years ago")
    end
  end

  describe "associations" do
    it { should belong_to(:department) }
    it { should have_many(:vacations) }
    it { should have_many(:position_histories) }
    it { should have_many(:positions).through(:position_histories) }
  end
end
