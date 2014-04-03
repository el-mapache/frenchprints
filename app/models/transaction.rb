class Transaction < ActiveRecord::Base
  attr_accessible :artwork_id, :buyer_id, :description, :seller_id, :sold_on,
                  :buyer, :seller, :artwork

  belongs_to :artwork
  belongs_to :buyer, class_name: "Person", foreign_key: :buyer_id
  belongs_to :seller, class_name: "Person", foreign_key: :seller_id

  validates :artwork_id, :buyer_id, :seller_id, :sold_on, presence: true
  validates :sold_on, uniqueness: {
    scope: [:artwork_id, :buyer_id, :seller_id]
  }
end
