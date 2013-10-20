# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    start_date "2013-10-18"
    end_date "2013-10-18"
    city "Cleveland"
    country "United States"
    country_code "US"
    street_address "1929 W Larchmere"
    latitude ""
    longitude ""
  end
end
