require 'spec_helper'

describe Journal do
  context "accessibility" do
    it { should allow_mass_assignment_of :publication_run }
    it { should allow_mass_assignment_of :title }
    it { should allow_mass_assignment_of :personnel_histories_attributes }
    it { should allow_mass_assignment_of :locations_attributes }
  end

  context "associations" do
    it { should have_many(:locations) }
    it { should have_many(:personnel_histories) }
    it { should have_many(:articles) }
  end

  context "validations" do
    it { should validate_presence_of :title }
  end

  describe "on destroy" do
    it "deletes all associated personnel_records" do
      journal = create(:journal)
      journal.locations.create(FactoryGirl.attributes_for(:location))
      journal.personnel_histories.create(FactoryGirl.attributes_for(:personnel).merge!({person_id: create(:person).id, location_id: journal.locations.first.id}))
      lambda do
        journal.destroy
      end.should change(PersonnelHistory, :count).by(-1)
    end
  end
end
