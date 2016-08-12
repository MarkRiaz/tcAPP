FactoryGirl.define do
  factory :answer do
    association :question
    title "MyString"
    body "MyText"   
  end
end
