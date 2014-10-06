require 'spec_helper'

describe Admin::JournalsController do
  login_admin

  describe "'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "fetches an array of all journals" do
      get "index"
      expect(assigns(:journals)).to_not be_nil
    end
  end

  describe "'new'" do
    before :each do
      get 'new'
    end

    it "returns http success" do
      response.should be_success
    end

    it "creates a new journal" do
      expect(assigns(:journal)).to_not be_nil
    end
  end

  describe "#create" do
    context "successful save" do
      before :each do
        post 'create', journal: FactoryGirl.attributes_for(:journal), 
              locations_attributes: {
                "0" => { 
                  "event_name"=>"Initial Publication", 
                  "street_address"=>"123 Rue du Nord", 
                  "city"=>"Paris", 
                  "country"=>"France", 
                  "state"=>"", 
                  "province"=>"",
                  "start_date"=>"20-08-1883"
                } 
              }
      end

      it "persists a journal to the database on success" do
        Journal.all.count.should eql(1)
      end
      
      it "saves nested locations" do
        journal = assigns :journal
        journal.locations.should_not be_nil
      end

      it "displays a flash message on success" do
        flash[:notice].should_not be_nil
      end

      it "redirects to the journals index" do
        response.should redirect_to(admin_journals_path)
      end
    end

    context "unsuccessful save" do
      before :each do
        post :create, journal: {}
      end

      it "rerenders the new page" do
        response.should render_template "new"
      end
    end
  end

  describe "#update" do
    before :each do
      @journal ||= create(:journal)
      put "update", id: @journal, journal: {title: "Guns and Ammo"}
    end

    context "success" do
      it "updates a resource" do
        j = assigns(:journal)
        j.title.should eql("Guns and Ammo")
      end

      it "redirects to index" do
        response.should redirect_to admin_journals_path
      end

      it "populates the flash notice" do
        flash[:notice].should_not be_nil
      end
    end

    context "unsuccessful update" do
      it "renders the edit partial" do
        put 'update', id: @journal, journal: {title: ""}
        response.should render_template "edit"
      end
    end
  end

  describe "#destroy" do
    before :each do 
      @journal ||= create(:journal)
    end

    it "deletes a journal record" do
      lambda do
        delete 'destroy', id: @journal
      end.should change(Journal, :count).by(-1)
    end

    it "redirects to the index on delete" do
      delete 'destroy', id: @journal
      response.should redirect_to(admin_journals_path)
    end
  end
end
