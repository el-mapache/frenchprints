require 'spec_helper'

describe Admin::PeopleController do
  let(:admin) { test_sign_in(:admin) }
  
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
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "'show'" do
    it "returns http success" do
      #get 'show'
      #response.should be_success
    end
  end

  describe "'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end
  end

  describe "'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "'update'" do
    it "returns http success" do
      put 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do

    it "returns http success" do
      #get 'destroy'
      #response.should be_success
    end

    it "deletes a user record" do
    end
  end

end
