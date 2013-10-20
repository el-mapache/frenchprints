require 'spec_helper'

describe Location do
  context "accessibility" do
    it { should allow_mass_assignment_of :city }
    it { should allow_mass_assignment_of :country }
    it { should allow_mass_assignment_of :country_code }
    it { should allow_mass_assignment_of :start_date }
    it { should allow_mass_assignment_of :end_date }
    it { should allow_mass_assignment_of :latitude }
    it { should allow_mass_assignment_of :longitude }
    it { should allow_mass_assignment_of :street_address }
  end

  context "associations" do
    it { should belong_to(:locatable) }
  end

  context "validations" do
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :country }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
  end
end
