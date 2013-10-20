# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    start_date "2013-10-18"
    end_date "2013-10-18"
    city "MyString"
    country "MyString"
    country_code "MyString"
    street_address "MyString"
    latitude "MyString"
    longitude "MyString"
  end
end
