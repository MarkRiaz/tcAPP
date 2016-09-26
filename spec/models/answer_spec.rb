require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }
  it { should validate_length_of(:body).is_at_least(1)
 				       .is_at_most(500) }
  it {should validate_presence_of :user_id}
  it { should belong_to :user}
  it { should belong_to :question }
  it { should have_many :attachments }
  it { should accept_nested_attributes_for :attachments }
  
  describe 'check_best' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question, user: user, best: false) }
    let!(:answer2) { create(:answer, question: question, user: user, best: true) }

    it 'check best answer' do
      answer.best!
      answer.reload
      answer2.reload
      expect(answer.best).to eq true
      expect(answer2.best).to eq false
    end
  end
end
