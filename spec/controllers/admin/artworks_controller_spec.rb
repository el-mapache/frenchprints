require 'spec_helper'

describe Admin::ArtworksController do
  login_admin
  let(:person) { create(:person, name: "fakey johnson") }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "returns some artworks" do
      get "index"
      artworks = assigns(:artworks)
      artworks.should_not be_nil
    end
  end

  context "nested resource" do
    describe "GET 'new'" do
      before :each do
        get 'new', person_id: person.id
      end

      it "returns http success" do
        get 'new', person_id: person.id
        response.should be_success
      end

      it "returns a new artwork record" do
        artwork = assigns(:artwork)
        artwork.new_record?.should be true
      end
    end

    describe "GET 'show'" do
      before :each do
        @artwork ||= create(:artwork)
        get 'show', person_id: @artwork.artist.id, id: @artwork.id
      end

      it "returns http success" do
        response.should be_success
      end

      it "returns an instance of an artwork" do
        art = assigns(:artwork)
        art.should_not be_nil
      end
    end

    describe "GET 'edit'" do
      before :each do
        @artwork ||= create(:artwork)
        get 'edit', person_id: @artwork.artist.id, id: @artwork.id
      end

      it "returns http success" do
        response.should be_success
      end

      it "returns an instance of an artwork" do
        art = assigns(:artwork)
        art.should_not be_nil
      end
    end

    describe "POST 'create'" do
      context "success" do
        before :each do
          post :create, person_id: person.id, artwork: {
            title: "Janie Jones",
            medium: "LP",
            release_date: "1977-09-22",
            dimensions: "N/A"
          }
        end

        it "creates an artwork record" do
          art = assigns(:artwork)
          art.title.should eql "Janie Jones"
        end

        it "populates the flash with a success notice" do
          flash[:notice].should_not be_nil
        end

        it "redirects to the artworks index page" do
          response.should redirect_to(admin_artworks_path)
        end
      end

      context "failure" do
        it "redirects to the 'new' page" do
          post :create, person_id: person.id, artwork: {}
          response.should render_template "new"
        end

        it "populates the artwork with error messages" do
          post :create, person_id: person.id, artwork: {}
          art = assigns(:artwork)
          art.errors.should_not be_nil
        end
      end
    end

    describe "PUT 'update'" do
      let(:artwork) { create(:artwork) }

      before :each do
        put :update, person_id: person, id: artwork, artwork: { title: "Kitten Explosion"}
      end

      it "successfully updates the record" do
        art = assigns(:artwork)
        art.title.should eql "Kitten Explosion"
      end

      it "redirects to the index page" do
        response.should redirect_to(admin_artworks_path)
      end
    end
  end

  describe "DELETE 'destroy'" do
    let(:artwork) { create(:artwork) }

    before :each do
      @artwork ||= create(:artwork)
    end

    it "destroys a record" do
      lambda do
        delete :destroy, id: @artwork.id
      end.should change(Artwork, :count).by(-1)
    end

    it "populates the flash with a success message" do
      delete :destroy, id: @artwork.id
      flash[:notice].should_not be_nil
    end

    it "redirects to the artworks index page" do
      delete :destroy, id: @artwork.id
      response.should redirect_to(admin_artworks_path)
    end
  end
end

