# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    user_id 1
    company_id 1
    date_start "2012-11-10"
    date_end "2012-11-10"
    city "MyString"
    state "MyString"
  end
end
