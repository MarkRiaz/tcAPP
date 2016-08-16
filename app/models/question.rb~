class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  validates :title, presence:  true, length: { maximum: 50, minimum: 1 } 
  validates :body, presence:  true, length: { maximum: 500, minimum: 1 }
end
