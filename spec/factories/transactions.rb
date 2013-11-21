# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    description "MyText"
    artwork_id 1
    buyer_id 1
    seller_id 1
    sold_on "2013-11-20"
  end
end
