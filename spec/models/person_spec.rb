require 'spec_helper'

describe Person do
  context "accessibility" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :bio }
    it { should_not allow_mass_assignment_of :id }
  end

  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  context "associations" do
    it { should have_and_belong_to_many :roles }
    it { should have_many :representations }
    it { should have_many :artworks }

    context "representations" do
      let(:person) { create(:person) }
      # A representee is defined as an instance of Person
      # who is an artist and is associated with a dealer
      it "shows all representees for a given person" do
        person.representees.should eql([])
      end
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

    describe "#represent" do
      let(:artiste) { create(:person, name: "Filippo Marinetti") }

      it "adds an error if the representor isn't a dealer" do
        artiste.represent(person.id, Date.yesterday, Date.tomorrow)
        artiste.errors.should_not be_nil
      end

      it "adds a representation between dealer and artist" do
        person.add_role("Dealer")
        person.represent(artiste.id, Date.yesterday, Date.tomorrow)
        person.representees.count.should be(1)
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

    context "Representative/ee finder methods" do
      let(:dealer) { create(:dealer) }
      let(:painter) { create(:artist) }
      let(:sothebys) { create(:dealer, name: "Wilshire Brimsford") }

      describe ".representatives" do
        it "fetches all representatives for a given person" do
          dealer.represent(painter.id, Date.yesterday, Date.tomorrow) 
          sothebys.represent(painter.id, Date.yesterday, Date.tomorrow) 
          painter.representatives.count.should be(2)
        end
      end

      describe "#was_represented_during" do
        it "gets all representatives for an artist in a given timeframe" do
          dealer.represent(painter.id, Date.yesterday, Date.tomorrow) 
          sothebys.represent(painter.id, 10.days.ago.to_date, 1.year.from_now.to_date) 
          debugger
          painter.was_represented_during(Date.yesterday, Date.tomorrow).count.should be(1)
        end
      end
    end
  end
end
