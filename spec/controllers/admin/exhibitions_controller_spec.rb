require 'spec_helper'

describe Admin::ExhibitionsController do
  login_admin

  describe "#index" do
    before :each do
      get "index"
    end

    it "returns http success" do
      response.should be_success
    end

    it "returns an array of exhibitions" do
      exhibits = assigns(:exhibitions)
      exhibits.should_not be_nil
    end
  end

  describe "#new" do
    before :each do
      @gallery ||= create(:gallery)
      get "new", gallery_id: @gallery
    end

    it "returns http success" do
      response.should be_success
    end

    it "returns a new resource" do
      exhibit = assigns(:exhibition)
      exhibit.new_record?.should eq true
    end
  end

  describe "#show'" do
    before :each do
      @exhibition ||= create(:exhibition)
      get "show", id: @exhibition
    end

    it "returns http success" do
      response.should be_success
    end

    it "returns the specified gallery" do
      exhibit = assigns(:exhibition)
      exhibit.name.should eq(@exhibition.name)
    end
  end

  describe "#edit" do
    before :each do
      @gallery ||= create(:gallery)
      @exhibition = @gallery.exhibitions.create(FactoryGirl.attributes_for(:exhibition))
      get "edit", gallery_id: @gallery, id: @exhibition
    end

    it "returns http success" do
      response.should be_success
    end

    it "returns the specified gallery" do
      ex = assigns(:exhibition)
      ex.should_not be_nil
    end
  end

  describe "#create" do
    before :each do
      @gallery ||= create(:gallery)
    end

    context "success" do
      it "redirects to the gallery" do
        post :create, gallery_id: @gallery, exhibition: {
          name: "Fantastik Computer Musik",
          description: "Synth Explosion"
        }
        response.should redirect_to admin_gallery_path(@gallery)
      end

      it "creates exhibition artists" do
        post :create, gallery_id: @gallery, exhibition: {
          name: "Fantastik Computer Musik",
          description: "Synth Explosion"
        },
        exhibitions_artists: {
          "0" => {
            person_id: create(:person).id
          }
        }

        exhibit = assigns(:exhibition)
        exhibit.exhibitions_artists.should_not be_empty
      end
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "#destroy" do
    before :each do
      @exhibition ||= create(:exhibition)
    end

    it "deletes the exhibition" do
      lambda do
        delete :destroy, id: @exhibition
      end.should change(Exhibition, :count).by(-1)
    end

    it "redirects to the exhibitions index" do
      delete :destroy, id: @exhibition
      response.should redirect_to admin_exhibitions_path
    end

    it "populates the flash notice" do
      delete :destroy, id: @exhibition
      flash[:notice].should_not be_nil
    end
  end

end
