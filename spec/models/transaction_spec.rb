require 'spec_helper'

describe Transaction do
  context "accessibility" do
    %w(seller_id buyer_id description artwork_id sold_on).each do |attr|
      it { should allow_mass_assignment_of attr }
    end

    it { should_not allow_mass_assignment_of :id }
  end


  context "associations" do
    it { should belong_to :artwork }
    it { should belong_to :buyer }
    it { should belong_to :seller }
  end


  context "validations" do
    %w(seller_id buyer_id artwork_id sold_on).each do |attr|
      it { should validate_presence_of attr }
    end

    it "ensures the same transaction doesnt go through twice" do
      artwork = create(:artwork)
      dealer = create(:dealer)
      buyer = create(:person, name: "Billy Blanks")

      valid_sale = Transaction.create({artwork_id: artwork.id,
                                       seller_id: dealer.id,
                                       buyer_id: buyer.id,
                                       sold_on: Date.today})
      valid_sale.should be_valid

      Transaction.create({artwork_id: artwork.id,
                                       seller_id: dealer.id,
                                       buyer_id: buyer.id,
                                       sold_on: Date.today}).should_not be_valid

      Transaction.create({
        artwork_id: artwork.id,
        seller_id: buyer.id,
        buyer_id: dealer.id,
        sold_on: Date.today
      }).should be_valid
    end
  end
end
