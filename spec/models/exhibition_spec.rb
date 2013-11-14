require 'spec_helper'

describe Exhibition do
  context "accessibility" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :person_id }
    it { should allow_mass_assignment_of :gallery_id }
    it { should allow_mass_assignment_of :locations_attributes }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :organizer }
    it { should belong_to :gallery }
    it { should have_many :locations }
    it { should have_many :exhibitions_artists }
    it { should have_many(:artists).through(:exhibitions_artists) }
  end

  context "validations" do
    it { should validate_presence_of :name }
  end
end
