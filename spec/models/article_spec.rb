require 'spec_helper'

describe Article do
  context "accessibility" do
    it { should allow_mass_assignment_of :date_published }
    it { should allow_mass_assignment_of :journal }
    it { should allow_mass_assignment_of :pages }
    it { should allow_mass_assignment_of :title }
    it { should allow_mass_assignment_of :authors_articles_attributes }
    it { should allow_mass_assignment_of :issue_number }
    it { should_not allow_mass_assignment_of :id }
  end

  context "associations" do
    it { should belong_to :journal }
    it { should have_many :authors_articles }
    it { should have_many(:authors).through(:authors_articles) }
    it { should accept_nested_attributes_for(:authors_articles) }
    it { should have_many(:subjects) }
  end

  context "validations" do
    it { should validate_presence_of :date_published }
    it { should validate_presence_of :journal_id }
    it { should validate_presence_of :pages }
    it { should validate_presence_of :title }
  end
end
