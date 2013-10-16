require 'spec_helper'

describe Person do
  context "accessibility" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :bio }
    it { should_not allow_mass_assignment_of :id }
  end

  context "validations" do
    it { should validate_presence_of :name }
  end

  context "associations" do
    it { should have_and_belong_to_many :roles }
    it { should have_many :representations }
    it { should have_many :artworks }

    # A representee is defined as an instance of Person
    # who is an artist and is associated with a dealer
    it "allows readonly access to all representees" do
    end

    it "allows readonly access to all representitives" do
    end
  end


  context "instance methods" do
    let(:person) { create(:person) }

    describe "#add_role" do
      it "increases roles count" do
        lambda do
          person.add_role("Lion Tamer")
        end.should change(person.roles, :count).by(1)
      end

      it "adds a role to the person's roles list" do
        person.add_role("Lion Tamer")
        person.roles.first.name.should eql("Lion Tamer")
      end

      it "doesn't duplicate a role if the same is added" do
        person.add_role("Lion Tamer")
        count = person.roles.count
        person.add_role("Lion Tamer")
        count.should eq(person.roles.count)
      end
    end

    describe "#add_artwork" do
      let(:artwork) { {title: "Masterpiece, the third", release_date: Date.today, medium: "Canvas and crayon"} }
      it "doesnt add an artwork if the person isn't an artist" do 
        person.add_artwork(artwork)
        person.errors.should_not be_nil
      end

      it "increases produced_works count when valid" do
        person.add_role("Artist")
        person.add_artwork(artwork)
        person.artworks.count.should be(1)
      end
    end
  end
end
