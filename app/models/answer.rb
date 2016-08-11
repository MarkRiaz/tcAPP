class Answer < ApplicationRecord
  belongs_to :question
  validates :title, presence: true, length: { maximum: 50, minimum: 1 } 
  validates :body, presence: true,  length: { maximum: 500, minimum: 1 }
  validates :question_id, presence: true
end
