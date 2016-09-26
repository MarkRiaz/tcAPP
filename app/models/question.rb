class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy, as: :attachable
  validates :user_id, :body, :title, presence:  true
  validates :title, length: { maximum: 50, minimum: 1 }
  validates :body, length: { maximum: 500, minimum: 1 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
