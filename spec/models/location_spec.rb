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
    it { should allow_mass_assignment_of :state }
    it { should allow_mass_assignment_of :province }
  end

  context "associations" do
    it { should have_many(:location_events) }
  end

  context "validations" do
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :country }
  end
  
  describe "instantiation" do
    it "geocodes the lat/lng on successful validation" do
      location = create(:location)
      location.latitude.should_not be_nil
      location.longitude.should_not be_nil
    end
  end

  describe "#full_address" do
    it "creates a string representation of a location" do
      location = create(:location)
      location.full_address.should eql("1929 W Larchmere, Cleveland, United States")
    end
  end
end
