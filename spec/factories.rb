FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "abc#{n}@gmail.com" }
    password "fooAAnnn$$54"
    password_confirmation 'fooAAnnn$$54'
  end
end
