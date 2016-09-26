class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, dependent: :destroy, as: :attachable
  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { maximum: 500, minimum: 1 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  default_scope { order(best: :desc, created_at: :asc) }

  def best!
    Answer.transaction  do
    self.question.answers.where(best: true).update_all(best: false)
    self.best = true
    self.save!
    end
  end
end
