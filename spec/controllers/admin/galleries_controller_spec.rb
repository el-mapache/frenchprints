require 'spec_helper'

describe Admin::GalleriesController do
  login_admin

  describe "#index" do
    before :each do
      get "index"
    end

    it "returns http success" do
      response.should be_success
    end

    it "returns galleries" do
      galleries = assigns(:galleries)
      galleries.should_not be_nil
    end
  end

  describe "#new" do
    before :each do
      get "new"
    end

    it "returns http success" do
      response.should be_success
    end

    it "returns a new gallery resource" do
      gallery = assigns(:gallery)
      gallery.new_record?.should eq(true)
    end
  end

  context "get with resource id" do
    let(:gallery) { create(:gallery) }

    describe "#show" do
      before :each do
        get "show", id: gallery
      end

      it "returns http success" do
        response.should be_success
      end

      it "returns an existing gallery resource" do
        gallery = assigns(:gallery)
        gallery.name.should eq(gallery.name)
      end
    end

    describe "#edit" do
      before :each do
        get "edit", id: gallery
      end

      it "returns http success" do
        response.should be_success
      end

      it "returns an existing gallery resource" do
        gallery = assigns(:gallery)
        gallery.name.should eq(gallery.name)
      end
    end

    describe "#create" do
      before :each do
        post :create, gallery: { name: "Thomas Masters" }
      end

      context "success" do
        it "saves a new record" do
          assigns(:gallery).should be_valid
        end

        it "populates the flash with a notice" do
          flash[:notice].should_not be_nil
        end

        it "redirects to the index page" do
          response.should redirect_to(admin_galleries_path)
        end
      end  

      context "failure" do
        before :each do
          post :create, gallery: {}
        end

        it "doesn't save an invalid record" do
          assigns(:gallery).should_not be_valid
        end

        it "returns errors" do
          assigns(:gallery).errors.should_not be_nil
        end

        it "reenders the new page" do
          response.should render_template "new"
        end
      end
    end 

    describe "#update" do
      context "success" do
        before :each do
          @gallery ||= create(:gallery)
          put :update, id: @gallery, gallery: { name: "Thomas Masters" }
        end

        it "successfully updates the record" do
          @gallery.reload
          @gallery.name.should eq "Thomas Masters"
        end

        it "populates the flash notice" do
          flash[:notice].should_not be_nil
        end

        it "redirects to the index page" do
          response.should redirect_to(admin_galleries_path)
        end
      end
    end

    describe "#destroy" do
      before :each do
        @gallery ||= create(:gallery)
      end

      it "removes the record" do
        lambda do
          delete :destroy, id: @gallery
        end.should change(Gallery, :count).by(-1)
      end

      it "redirects to the index" do
        delete :destroy, id: @gallery
        response.should redirect_to(admin_galleries_path)
      end

      it "populates the flash notice" do
        delete :destroy, id: @gallery
        flash[:notice].should_not be_nil
      end
    end
  end
end

