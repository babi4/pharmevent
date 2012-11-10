# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :couriers_task do
    user_id 1
    name "MyString"
    telephone "MyString"
    from_date "MyString"
    to_date "MyString"
    status "MyString"
    to_person "MyString"
    from_couriers_company_id "MyString"
    to_couriers_company_id "MyString"
  end
end
