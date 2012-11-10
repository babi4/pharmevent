# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company_member do
    company_id 1
    name "MyString"
    telephone "MyString"
    position "MyString"
    email "MyString"
  end
end
