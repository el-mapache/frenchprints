require 'spec_helper'

describe Admin::PeopleController do
  login_admin 

  describe "'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "fetches an array of all people" do
      get "index"
      expect { assigns(:people) }.to_not be_nil
    end
  end

  describe "'new'" do
    before :each do
      get 'new'
    end

    it "returns http success" do
      response.should be_success
    end

    it "creates a new person" do
      expect { assigns(:person) }.to_not be_nil
    end

    it "creates a new birth record" do
      birth = assigns(:birth)
      birth.should_not be_nil
      birth.event_name.should eql("birth")
    end

    it "creates a new death record" do
      death = assigns(:death)
      death.should_not be_nil
      death.event_name.should eql("death")
    end
  end

  context "resources requiring an id" do
    before :each do
      Person.delete_all
    end

    describe "show" do
      before :each do
        @person ||= create(:person)
        get 'show', id: @person
      end

      it "returns http success" do
        response.should be_success
      end

      it "shows the requested person" do
        p = assigns(:person)
        p.should be_instance_of PersonPresenter
      end
    end

    describe "'create'" do

      before :each do
        Role.create(name: "Great Guy")
        post :create, person: {
          name: "Testy the test-guy",
          role_ids: [Role.first.id],
          locations_attributes: {
            "0" => { 
              "event_name"=>"birth", 
              "street_address"=>"123 Rue du Nord", 
              "city"=>"Paris", 
              "country"=>"France", 
              "state"=>"", 
              "province"=>"",
              "start_date"=>"20-08-1883"
            }, 
            "1"=>{ 
              "event_name"=>"death", 
              "street_address"=>"the guttter", 
              "city"=>"Barcelona", 
              "country"=>"spain", 
              "state"=>"", 
              "province"=>"",
              "start_date"=>"01-12-1920"
            }
          }
        }
      end

      it "returns http success" do
        post 'create'
        response.should be_success
      end

      context "successful save" do
        it "persists a new user to the database" do
          Person.all.count.should eql(1)
        end

        it "properly saves dates" do
          person = assigns(:person)
          person.locations.should_not be_nil
        end

        it "properly saves roles" do
          person = assigns(:person)
          person.roles.should_not be_nil
          person.roles.map { |r| r.name }.should include("Great Guy")
        end

        it "displays a flash message on success" do
          flash[:notice].should_not be_nil
        end

        it "redirects to the people index" do
          response.should redirect_to(admin_people_path)
        end
      end

      context "unsuccessful save" do
        it "rerenders the new page" do
          post :create, user: {}
          response.should render_template("new")
        end
      end
    end

    context "edit/update resource" do

      before :each do 
        @person ||= create(:person)
      end

      describe "#edit" do
        it "returns http success" do
          get "edit", id: @person
          response.should be_success
        end

        it "gets an instance of the specified person" do
          get "edit", id: @person
          p = assigns(:person)
          p.id.should eql(@person.id)
        end
      end

      describe "#update" do
        context "success" do
          it "updates the resource" do
            put 'update', id: @person, person: { name: "Bill Belamy" }
            p = assigns(:person)
            p.name.should eql("Bill Belamy")
          end

          it "redirects to the index on a successful update" do
            put 'update', id: @person, person: { name: "Bill Belamy" }
            response.should redirect_to(admin_people_path)
          end

          it "populates the flash with a notice" do
            put 'update', id: @person, person: { name: "Bill Belamy" }
            flash[:notice].should_not be_nil
          end
        end

        context "unsuccessful update" do
          it "renders the edit partial" do
            put 'update', id: @person, person: {name: ""}
            response.should render_template "edit"
          end
        end
      end
    end

    describe "GET 'destroy'" do
      before :each do 
        @person ||= create(:person)
      end

      it "deletes a user record" do
        lambda do
          delete 'destroy', id: @person
        end.should change(Person, :count).by(-1)
      end

      it "redirects to the index on delete" do
        delete 'destroy', id: @person
        response.should redirect_to(admin_people_path)
      end
    end
  end
end
