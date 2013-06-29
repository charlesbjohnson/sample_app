FactoryGirl.define do
  factory :user do
    name                  "Charlie Johnson"
    email                 "cjohnson@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end