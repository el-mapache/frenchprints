FactoryGirl.define do
  factory :person do
    name "John Doe"

    factory :artist do
      name "Kahinde Wiley"

      after(:create) { |person| person.add_role("Artist") }
    end

    factory :dealer do
      name "James"

      after(:create) { |person| person.add_role("Dealer") }
    end
  end
end
