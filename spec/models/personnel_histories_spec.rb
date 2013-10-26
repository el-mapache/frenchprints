require 'spec_helper'

describe PersonnelHistory do
  context "accessibility" do
    it { should allow_mass_assignment_of :person_id }
    it { should allow_mass_assignment_of :start_date }
    it { should allow_mass_assignment_of :end_date }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :person }
    it { should belong_to :trackable }
  end

  context "validations" do
    it { should validate_presence_of :person_id }
    it { should validate_presence_of :start_date }
  end
end
