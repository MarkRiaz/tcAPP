class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :user_id, :body, :title, presence:  true
  validates :title, length: { maximum: 50, minimum: 1 }
  validates :body, length: { maximum: 500, minimum: 1 }

  def answers_without_best
    answers.reject{ |answer| answer.id == best_answer_id }
  end

  def best_answer
    Answer.find_by_id(best_answer_id)
  end

end
