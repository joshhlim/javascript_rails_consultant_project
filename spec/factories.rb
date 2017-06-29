FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
      content "Lorem ipsum"
      user
  end

  factory :make do
    sequence(:name) { |n| "Make #{n}" }
  end

  factory :model do
    sequence(:name) { |n| "Model #{n}" }
    make
  end

  factory :model_year do
    year { 1970 + rand(45) }
    model
  end

  factory :feature do
    name 'Maintenance Log'
    initialize_with { Feature.find_or_create_by(name: name) }
  end
end
