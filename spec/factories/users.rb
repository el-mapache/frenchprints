FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "user#{Time.now.to_i + n}@email.com" }
    password "123qweasd"

    factory :admin do
      admin true
    end
  end
end
