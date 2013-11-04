require 'spec_helper'

describe AuthorsArticle do
  context "accessibility" do
    it { should allow_mass_assignment_of :article_id }
    it { should allow_mass_assignment_of :person_id }
    it { should_not allow_mass_assignment_of :id }
  end
  
  context "associations" do
    it { should belong_to :article }
    it { should belong_to :author }
  end

  context "validations" do
    it { should validate_presence_of :person_id }
    it { should validate_presence_of :article_id }
  end
end
