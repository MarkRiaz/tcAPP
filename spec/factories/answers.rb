FactoryGirl.define do
  factory :answer do
    association :question
    title "MyString"
    body "MyText"   
  end
  factory :invalid_answer, class: "answer" do
    title nil
    body nil
    association :question	
 end
end
