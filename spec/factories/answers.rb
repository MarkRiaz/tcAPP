FactoryGirl.define do

  sequence :body do |n|
    "my text#{n}"
  end

  factory :answer do
    user
    question
    body    
  end

  factory :invalid_answer, class: "answer" do
    body nil
  end

end
