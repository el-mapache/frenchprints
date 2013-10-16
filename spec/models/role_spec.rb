require 'spec_helper'

describe Role do
  context "accessibility" do
    it { should allow_mass_assignment_of :name }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should have_and_belong_to_many :people }
  end

  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end
end
