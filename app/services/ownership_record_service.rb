class OwnershipRecordService
  def initialize(params)
    raise ArgumentError if (params.nil? || params.empty?)

    @artwork = Artwork.find(params[:artwork_id])
    @transaction = @artwork.transactions.build(params[:transaction])
    @ownership_record = nil
  end

  def create_transaction
    return create_or_update_ownership if @artwork.save

    false
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
  end

  def has_previous_owner?
    owner = Person.find(@transaction.seller_id)

    owner.ownerships.where(artwork_id: @artwork.id, end_date: nil).first
  end
end
