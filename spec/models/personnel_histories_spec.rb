require 'spec_helper'

describe PersonnelHistory do
  context "accessibility" do
    it { should allow_mass_assignment_of :person_id }
    it { should allow_mass_assignment_of :location_id }
    it { should allow_mass_assignment_of :start_date }
    it { should allow_mass_assignment_of :end_date }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :person }
    it { should belong_to :location }
    it { should belong_to :trackable }
  end

  context "validations" do
    it { should validate_presence_of :person_id }
    it { should validate_presence_of :location_id }
    it { should validate_presence_of :start_date }
    it { should validate_uniqueness_of(:start_date).scoped_to(:trackable_id, :location_id, :start_date, :end_date) }
  end
end
