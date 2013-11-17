require 'spec_helper'

describe Gallery do
  context "has_media" do
    include_context "has_media"
  end

  context "accessibility" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :locations_attributes }
    it { should allow_mass_assignment_of :personnel_histories_attributes }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should have_many :locations }
    it { should have_many :personnel_histories }
    it { should have_many :exhibitions }
  end

  context "validations" do
    it { should validate_presence_of :name }
  end

  context "before destroy cleanup" do
    before :each do
      @gallery = create(:gallery)
    end

    it "removes exhibitions" do
      exhibit = @gallery.exhibitions << create(:exhibition)

      @gallery.destroy
      exhibit.reload
      exhibit.should be_empty
    end

    it "removes locations" do
      @gallery.locations.create(FactoryGirl.attributes_for(:location))

      lambda do
        @gallery.destroy
      end.should change(Location, :count).by(-1)
    end

    it "removes personnel histories" do
      @gallery.locations.create(FactoryGirl.attributes_for(:location))
      @gallery.personnel_histories.create(FactoryGirl.attributes_for(:personnel).merge!({person_id: create(:person).id, location_id: @gallery.locations.first.id}))
      lambda do
        @gallery.destroy
      end.should change(PersonnelHistory, :count).by(-1)
    end
  end
end
