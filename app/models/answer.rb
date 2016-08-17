class Answer < ApplicationRecord
  belongs_to :question
  validates :body, :question_id, presence: true
  validates :body, length: { maximum: 500, minimum: 1 } 
end
