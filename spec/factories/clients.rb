# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    name "MyString"
    birthday "2012-11-10"
    passport_number "MyString"
    zagran_passport_number "MyString"
    zagran_passport_use_before "2012-11-10"
    degree "MyString"
    position "MyString"
    work "MyString"
    notes "MyString"
  end
end
