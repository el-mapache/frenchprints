class Admin::TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Artwork.find(params[:artwork_id]).transactions.build
  end

  def create
    @transaction = Artwork.find(params[:artwork_id]).transactions.build(params[:transaction])

    respond_to do |f|
      if @transaction.save
        f.html { redirect_to admin_transactions_path, notice: "Transaction successfully created" }
      else
        f.html { render "new", error: @transaction.errors.full_messages }
      end
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    respond_to do |f|
      if @transaction.delete
        f.html { redirect_to admin_transactions_path, notice: "Record successfully deleted" }
      end
    end
  end
end
