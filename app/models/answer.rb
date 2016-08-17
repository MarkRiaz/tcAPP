class Answer < ApplicationRecord
  belongs_to :question
  validates :title, :body, :question_id, presence: true
  validates :title, length: { maximum: 50, minimum: 1 } 
  validates :body, length: { maximum: 500, minimum: 1 } 
end
