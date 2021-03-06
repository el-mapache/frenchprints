require 'spec_helper'

describe Artwork do
  context "has_media" do
    include_context "has_media"
  end

  context "accessibility" do
    it { should allow_mass_assignment_of :artist_id }
    it { should allow_mass_assignment_of :dimensions }
    it { should allow_mass_assignment_of :medium }
    it { should allow_mass_assignment_of :release_date }
    it { should allow_mass_assignment_of :title }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :artist }
    it { should have_many :transactions }
  end

  context "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :medium }
    it { should validate_presence_of :artist_id }
    it { should validate_presence_of :release_date }
  end
end
