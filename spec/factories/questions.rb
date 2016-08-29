FactoryGirl.define do
  
  sequence :title do |n|
    "My string#{1}"
  end

  factory :question do
    user
    title 
    body "MyText"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
