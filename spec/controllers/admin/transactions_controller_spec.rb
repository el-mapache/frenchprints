require 'spec_helper'

describe Admin::TransactionsController do
  login_admin

  let(:artwork) { create(:artwork) }
  let(:dealer) { create(:dealer) }
  let(:buyer) { create(:person, name: "Richee McGee") }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "returns an array of all transactions" do
      get "index"
      t = assigns :transactions
      t.kind_of?(Array).should eql(true)
    end
  end

  describe "GET 'new'" do

    before :each do
      get "new", artwork_id: artwork.id
    end

    it "returns http success" do
      response.should be_success
    end

    it "builds a new transaction" do
      t = assigns(:transaction)
      t.should_not be_nil
    end

    it "is scoped with an artwork" do
      t = assigns(:transaction)
      t.artwork_id.should_not be_nil
    end
  end

  describe "post #create" do

    context "success" do
      it "persists a new transaction" do
        lambda do
          post 'create', artwork_id: artwork.id, transaction: {
            buyer_id: buyer.id, seller_id: dealer.id, sold_on: Date.today
          }
        end.should change(Transaction, :count).by 1
      end

      it "creates ownership records" do
        lambda do
          post 'create', artwork_id: artwork.id, transaction: {
            buyer_id: buyer.id, seller_id: dealer.id, sold_on: Date.today
          }
        end.should change(Ownership, :count).by 1
      end

      it "redirects to the transaction index" do
        post 'create', artwork_id: artwork.id, transaction: {
          buyer_id: buyer.id, seller_id: dealer.id, sold_on: Date.today
        }
        response.should redirect_to admin_transactions_path
      end

      it "populates the flash notice" do
        post 'create', artwork_id: artwork.id, transaction: {
          buyer_id: buyer.id, seller_id: dealer.id, sold_on: Date.today
        }
        flash[:notice].should_not be_nil
      end
    end

    context "failure" do
      it "renders the new action" do
        post "create", artwork_id: artwork.id, transaction: {}
        response.should render_template "new"
      end

      it "doesnt save the record" do
        lambda do
          post "create", artwork_id: artwork.id, transaction: {}
        end.should_not change(Transaction, :count)
      end
    end
  end

  describe "delete 'destroy'" do
    let(:transaction) { create(:transaction) }
    it "removes a record" do
      t = create(:transaction, sold_on: Date.tomorrow)
      lambda do
        delete 'destroy', id: t.id
      end.should change(Transaction, :count).by -1
    end

    it "redirects to the index" do
      delete "destroy", id: transaction.id
      response.should redirect_to admin_transactions_path
    end

    it "populates the flash notice" do
      delete "destroy", id: transaction.id
      flash[:notice].should_not be_nil
    end
  end

end
