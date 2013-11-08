require 'spec_helper'

describe Subject do
  context "accessibility" do
    it { should allow_mass_assignment_of :article_id }
    it { should allow_mass_assignment_of :subjectable_type }
    it { should allow_mass_assignment_of :subjectable_id }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :subjectable }
    it { should belong_to :article }
  end

  context "validations" do
    it { should validate_presence_of :article_id }
    it { should validate_presence_of :subjectable_id }
    it { should validate_presence_of :subjectable_type }
  end
end
