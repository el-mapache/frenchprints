# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exhibition do
    name "Parallaxian"
    person_id 1   
    # associations
    gallery
  end
end
