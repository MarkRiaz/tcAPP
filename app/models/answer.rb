class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { maximum: 500, minimum: 1 }
end
