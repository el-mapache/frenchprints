FactoryGirl.define do
  factory :artwork do
    title "Stormy Nitezzz"
    medium "balsa wood and fear"
    dimensions "234x1"
    release_date Date.today

    association :artist, factory: :person
  end
end
