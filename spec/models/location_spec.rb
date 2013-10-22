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
    it { should allow_mass_assignment_of :event_name }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to(:locatable) }
  end

  context "validations" do
  end
  
  describe "instantiation" do
    it "is not valid without an association" do
      expect { create(:location) }.to raise_error
    end

    it "geocodes the lat/lng on successful validation" do
      location = create(:person).locations.create(FactoryGirl.attributes_for :location)
      location.latitude.should_not be_nil
      location.longitude.should_not be_nil
    end
  end

  describe "#full_address" do
    it "creates a string representation of a location" do
      location = create(:person).locations.create(FactoryGirl.attributes_for :location)
      location.full_address.should eql("1929 W. Larchmere, Cleveland, United States")
    end
  end
end
