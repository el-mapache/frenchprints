class Admin::TransactionsController < Admin::AdminController
  def index
    @transactions = Transaction.includes(:artwork, :buyer, :seller).all
  end

  def new
    @transaction = Artwork.find(params[:artwork_id]).transactions.build
  end

  def create
    @transaction = OwnershipRecordService.new(params).create_transaction
    respond_to do |f|
      if @transaction.valid?
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
