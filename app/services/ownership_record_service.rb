# This service creates a new transaction and creates a new ownership record,
# as well as updating an existing one for a given work of art.

class OwnershipRecordService
  # Find the artwork begin sold
  def initialize(params)
    raise ArgumentError if (params.nil? || params.empty?)

    @params = params
    @artwork = Artwork.find(@params[:artwork_id])
    @transaction = nil
    @ownership_record = nil
  end

  # Initialize a new transaction and attempt to save it
  # Return the transaction so the controller can asses validity and
  # redirect to the appropriate route
  def create_transaction
    @transaction = @artwork.transactions.build(@params[:transaction])
    return create_or_update_ownership if @artwork.save

    @transaction
  end

  private

  def create_or_update_ownership
    @ownership_record = has_previous_owner?

    if @ownership_record
      @ownership_record.update_attributes(end_date: @transaction.sold_on)
    end

    new_ownership
  end

  def new_ownership
    buyer = Person.find(@transaction.buyer_id)

    buyer.ownerships.create({
      artwork_id: @transaction.artwork_id,
      start_date: @transaction.sold_on
    })

    buyer.save

    @transaction
  end

  # Checks to see if the person selling the artwork was a previous
  # owner or not.
  #
  # This will probably need to change, as I imagine the previous owner won't
  # be the one selling it...they may be going through a third party like
  # a dealer or an auctioneer.
  #
  # Returns either an active record object or nil
  def has_previous_owner?
    Person.find(@transaction.seller_id).ownerships.where({
      artwork_id: @artwork.id,
      end_date: nil
    }).first
  end
end
