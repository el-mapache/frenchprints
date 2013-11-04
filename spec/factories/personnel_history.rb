FactoryGirl.define do
  factory :personnel, class: PersonnelHistory do
    person
    location
    journal
    start_date "12-12-2013"
    end_date "12-12-2015"
  end
end
