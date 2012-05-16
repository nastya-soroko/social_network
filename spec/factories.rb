FactoryGirl.define do
  factory :user do
    name                  "Nastya Soroko"
    email                 "soroko_a@tut.by"
    password              "qwerty"
    password_confirmation "qwerty"
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end

  factory :micropost do
    content     "Foo bar"
    association :user
  end

end
