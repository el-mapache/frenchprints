require 'spec_helper'

describe ExhibitionsArtist do
  context "accessibility" do
    it { should allow_mass_assignment_of :artist_id }
    it { should allow_mass_assignment_of :exhibition_id }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :exhibition }
    it { should belong_to :artist }
  end

  context "validations" do
    it { should validate_presence_of :artist_id }
    it { should validate_presence_of :exhibition_id }
  end
end
