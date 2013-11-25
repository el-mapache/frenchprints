require 'spec_helper'

describe Ownership do
  context "accessibility" do
    it { should allow_mass_assignment_of :artwork_id }
    it { should allow_mass_assignment_of :end_date }
    it { should allow_mass_assignment_of :start_date }
    it { should allow_mass_assignment_of :person_id }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :person }
    it { should belong_to :artwork }
  end

  context "validations" do
    it { should validate_presence_of :artwork_id }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :person_id }

    it "checks uniqueness scoped to person, start_date" do
      create(:ownership)

      expect { create(:ownership) }.to raise_error

      create(:ownership, start_date: Date.tomorrow).should be_valid
    end
  end
end
