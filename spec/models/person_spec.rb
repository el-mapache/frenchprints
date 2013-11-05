require 'spec_helper'

describe Person do
  context "accessibility" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :bio }
    it { should allow_mass_assignment_of :blurb }
    it { should allow_mass_assignment_of :sex }
    it { should allow_mass_assignment_of :role_ids }
    it { should allow_mass_assignment_of :locations_attributes }
    it { should_not allow_mass_assignment_of :id }
  end

  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should ensure_length_of(:blurb).is_at_most(140) }
    it { should allow_value(/M|F|U|O/).for(:sex) }
    it { should allow_value("Male").for(:sex) }
  end

  context "associations" do
    it { should have_and_belong_to_many :roles }
    it { should accept_nested_attributes_for :roles }
    it { should have_many :representations }
    it { should have_many :artworks }
    it { should have_many :locations }
    it { should accept_nested_attributes_for :locations }
    it { should have_many :authors_articles }
    it { should have_many(:articles).through(:authors_articles) }
    context "representations" do
      # A representee is defined as an instance of Person
      # who is an artist and is associated with a dealer

      it "shows all representees for a given person" do
        Person.delete_all
        create(:person).representees.should eql([])
      end
    end

    context "locations" do
      it "destroys associated locations when deleted" do
        person = create(:person)
        location = person.locations.create(FactoryGirl.attributes_for :location)
        lambda do
          person.destroy
        end.should change(Location, :count).by(-1)
      end
    end

    context "artwork" do
      it "destroys associated artworks when deleted" do
        person = create(:person)
        person.add_role("Artist")
        artwork = person.add_artwork(FactoryGirl.attributes_for :artwork)
        lambda do
          person.destroy
        end.should change(Artwork, :count).by(-1)
      end
    end
  end

  context "instance methods" do
    before :each do
      Person.delete_all
      @person ||= create(:person)
    end

    describe "#all_roles" do
      it "returns an array with the names of all the associated roles" do
        @person.all_roles.kind_of?(Array).should eq(true)
      end
    end

    describe "#has_role?" do
      it "returns a boolean if the user has a specified role" do
        @person.add_role("Artist")
        @person.has_role?("Lion Tamer").should eql(false)
        @person.has_role?("Artist").should eql(true)
      end
    end

    describe "#sex_from_code" do
      it "returns a humanized string of the sex code on the model" do
        @person.update_attribute(:sex, "M")
        @person.sex_from_code.should eql("Male")
      end
    end

    describe "#add_role" do
      it "increases the person's role count" do

        lambda do
          @person.add_role("Lion Tamer")
        end.should change(@person.roles, :count).by(1)

      end

      it "adds a role to the person's roles list" do
        @person.add_role("Lion Tamer")
        @person.roles.first.name.should eql("Lion Tamer")
      end

      it "doesn't duplicate a role" do

        @person.add_role("Lion Tamer")
        count = @person.roles.count
        @person.add_role("Lion Tamer")
        count.should eq(@person.roles.count)

      end
    end

    describe "#represent" do
      let(:artiste) { create(:person, name: "Filippo Marinetti") }

      it "adds an error if the representor isn't a dealer" do
        artiste.represent(@person, Date.yesterday, Date.tomorrow)
        artiste.errors.should_not be_nil
      end

      it "adds a representation between dealer and artist" do
        @person.add_role("Dealer")
        @person.represent(artiste, Date.yesterday, Date.tomorrow)
        @person.representees.count.should be(1)
      end
    end

    describe "#add_artwork" do
      let(:artwork) { {title: "Masterpiece, the third", release_date: Date.today, medium: "Canvas and crayon"} }
      
      before :each do
        Person.delete_all
        @person = create(:person)
      end

      it "doesnt add an artwork if the person isn't an artist" do 
        @person.add_artwork(artwork)
        @person.errors.should_not be_nil
      end

      it "increases artworks count when valid" do
        @person.add_role("Artist")
        @person.add_artwork(artwork)
        @person.artworks.count.should be(1)
      end
    end
  
    context "Representative/ee finder methods" do
      let(:dealer) { create(:dealer) }
      let(:painter) { create(:artist) }
      let(:sothebys) { create(:dealer, name: "Wilshire Brimsford") }

      describe ".representatives" do
        it "fetches all representatives for a given person" do
          dealer.represent(painter, Date.yesterday, Date.tomorrow) 
          sothebys.represent(painter, Date.yesterday, Date.tomorrow) 
          painter.representative.count.should be(2)
        end

        it "returns an empty array if there are no representatives" do
          dealer.representative.should be_empty
        end
      end

      describe "#representees_during" do
        it "shows all representees of a dealer within supplied time frame"do
          dealer.represent(painter, Date.yesterday, Date.tomorrow) 
          dealer.representees_during(Date.yesterday, Date.tomorrow).length.should eq(1)
          dealer.representees_during(10.days.ago.to_date,Date.today).length.should eq(0)
        end
      end


      #describe "#was_represented_during" do
      #  it "gets all representatives for an artist in a given timeframe" do
      #    dealer.represent(painter, Date.yesterday, Date.tomorrow) 
      #    sothebys.represent(painter, 10.days.ago.to_date, 1.year.from_now.to_date) 
      #    painter.was_represented_during(Date.yesterday, Date.tomorrow).count.should be(1)
      #  end
      #end
    end
  end
end
