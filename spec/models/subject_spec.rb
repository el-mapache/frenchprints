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

  context "instance methods" do
    describe" #name" do
      it "normalizes the name property and returns it" do
        article = create(:article)
        art = create(:artwork)
        article.subjects << Subject.create(article_id: article.id, subjectable_type: "Artwork", subjectable_id: art.id)

        article.subjects.first.name.should eq "Stormy Nitezzz"
      end
    end
  end
end
