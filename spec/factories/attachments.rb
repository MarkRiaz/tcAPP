FactoryGirl.define do
  factory :attachment do
    file File.open(Rails.root.join('spec/rails_helper.rb'), 'r')
  end
end
