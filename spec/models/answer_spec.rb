require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id } 
  it { should validate_length_of(:title).is_at_least(1) 
  					.is_at_most(50) }
  it { should validate_length_of(:body).is_at_least(1) 
 				       .is_at_most(500) }
  it { should belong_to :question }
end