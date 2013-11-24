require 'spec_helper'

describe Admin::TransactionsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "post #create" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end
  end

  describe "delete 'destroy'" do
    it "returns http success" do
      delete 'destroy'
      response.should be_success
    end
  end

end
