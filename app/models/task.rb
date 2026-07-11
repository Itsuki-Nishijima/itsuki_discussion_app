class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board

  has_one_attached :eyecatch

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3 }
  validates :content, presence: true, length: { minimum: 10 }
end
