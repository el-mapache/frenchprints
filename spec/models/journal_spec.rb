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
  end

  context "validations" do
    it { should validate_presence_of :title }
  end
end
