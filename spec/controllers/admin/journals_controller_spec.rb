require 'spec_helper'

describe Admin::JournalsController do
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

    it "creates a new journal" do
      expect { assigns(:journal) }.to_not be_nil
    end
  end
end
