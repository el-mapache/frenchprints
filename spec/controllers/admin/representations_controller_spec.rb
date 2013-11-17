require 'spec_helper'

describe Admin::RepresentationsController do
  login_admin

  let(:dealer) { create(:dealer) }
  let(:artist) { create(:artist) }
  
  describe "#create" do
    context "success" do
      before :each do
        post 'create', person_id: dealer, representations: {
          "0" => {
            representee: artist.id,
            start_date: Date.yesterday,
            end_date: Date.tomorrow
          }
        }
      end

      it "associated new representations" do
        dealer.representations.length.should eq(1)
      end

      it "populates the flash notice" do
        flash[:notice].should_not be_nil
      end

      it "redirects to the person path" do
        response.should redirect_to(admin_person_path(dealer.id))
      end
    end

    context "failure" do
      before :each do
        request.env['HTTP_REFERER'] = admin_person_path(dealer)
      end

      it "redirects back" do
        post :create, person_id: dealer, representations: {}
        response.should redirect_to admin_person_path(dealer)
      end
    end
  end

  describe "#destroy" do
    before :each do
      @rep = dealer.represent(
        artist,
        Date.yesterday,
        Date.tomorrow
      )
    end

    it "removes representation record" do
      lambda do
        delete :destroy, person_id: dealer, id: @rep
      end.should change(Representation, :count).by(-1)
    end

    it "redirects to the person path" do
      delete 'destroy', person_id: dealer, id: @rep
      response.should redirect_to(admin_person_path(dealer.id))
    end
  end

end
