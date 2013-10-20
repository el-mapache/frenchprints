require 'spec_helper'

describe Representation do
  context "accessibility" do
    it { should allow_mass_assignment_of :start_date }
    it { should allow_mass_assignment_of :end_date }
    it { should allow_mass_assignment_of :representative }
    it { should allow_mass_assignment_of :representee }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :representee }
    it { should belong_to :representative }
  end

  context "validations" do
    it { should validate_presence_of :representee }
    it { should validate_presence_of :representative }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_uniqueness_of(:represented_id).scoped_to(:person_id, :start_date, :end_date) }
  end
end
