# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "On the superiority of Anglo-American Literature"
    date_published "1969-07-26"
    pages "122-135"

    journal
  end
end
