# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ownership do
    artwork_id 1
    person_id 1
    start_date "2013-11-24"
    end_date "2013-11-24"
  end
end
