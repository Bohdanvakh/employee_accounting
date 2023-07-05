require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { FactoryBot.create(:employee) }

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

  describe "vacation_days" do
    context "when employee has position" do
      let!(:position) { FactoryBot.create(:position, vacation_days: 10) }
      let!(:position_history) { FactoryBot.create(:position_history, employee: employee, position: position) }

      it "returns the vacation days of the last position" do
        expect(employee.vacation_days).to eq(10)
      end
    end

    context "when employee has no active positions" do
      it "returns 0" do
        expect(employee.vacation_days).to eq(0)
      end
    end
  end

  describe "remaining_vacation_days" do
    it "returns the difference between vacation_days and used_vacation_days" do
      allow(employee).to receive(:vacation_days).and_return(10)
      allow(employee).to receive(:used_vacation_days).and_return(5)

      expect(employee.remaining_vacation_days).to eq(5)
    end
  end

  describe "years of employment" do
    context "when employee started the last position" do
      let!(:position_history) { FactoryBot.create(:position_history, employee: employee, started_on: 3.years.ago) }

      it "returns the number of years of service at the company" do
        expect(employee.years_of_employment).to eq(3)
      end
    end

    context "when employee has no started last position" do
      it "returns 0" do
        expect(employee.years_of_employment).to eq(0)
      end
    end
  end

  describe "started_last_position" do
    context "when employee has position histories" do
      let!(:position_history) { FactoryBot.create(:position_history, employee: employee, started_on: 5.years.ago) }
      let!(:position_history) { FactoryBot.create(:position_history, employee: employee, started_on: 1.year.ago) }

      it "should return started_on date of the last position_history" do
        expect(employee.started_last_position).to eq(1.year.ago.to_date)
      end
    end

    context "when employee has no position histories" do
      it "returns nil" do
        expect(employee.started_last_position).to be_nil
      end
    end
  end

  describe "used_vacation_days" do
    context "when employee started their last position" do
      let!(:position_history) { FactoryBot.create(:position_history, employee: employee, started_on: 1.year.ago, finished_on: nil) }

      it "returns the total number of vacation days" do
        FactoryBot.create(:vacation, employee: employee, started_on: Date.today + 1.day, finished_on: Date.today + 6.days)
        FactoryBot.create(:vacation, employee: employee, started_on: Date.today + 10.days, finished_on: Date.today + 10.days + 5.days)

        expect(employee.used_vacation_days).to eq(10)
      end
    end

    context "when employee hasn't started the last position" do
      it "returns 0" do
        expect(employee.used_vacation_days).to eq(0)
      end
    end
  end

  describe "department_is_open" do
    let(:department) { FactoryBot.create(:department) }

    context "when department has less than 20 employees" do
      it "is valid" do
        FactoryBot.create_list(:employee, 19, department: department)
        employee = FactoryBot.build(:employee, department: department)

        expect(employee).to be_valid
      end
    end

    context "when department has 20 employees" do
      it "is not valid and returns error message" do
        FactoryBot.create_list(:employee, 20, department: department)
        employee = FactoryBot.build(:employee, department: department)

        expect(employee).not_to be_valid
        expect(employee.errors[:base]).to include("This department already has 20 employees")
      end
    end
  end

  describe "associations" do
    it { should belong_to(:department) }
    it { should have_many(:vacations) }
    it { should have_many(:position_histories) }
    it { should have_many(:positions).through(:position_histories) }
  end
end
