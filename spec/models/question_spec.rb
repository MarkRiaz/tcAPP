require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_length_of(:title).is_at_least(1) }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_length_of(:body).is_at_least(1) }
  it { should validate_length_of(:body).is_at_most(500) }
  it { should have_many(:answers).dependent(:destroy) }	
  it { should have_many :answers }
end
