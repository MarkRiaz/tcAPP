FactoryGirl.define do

  factory :answer do
    question
    body "MyText"   
  end

  factory :invalid_answer, class: "answer" do
    body nil
  end

end
