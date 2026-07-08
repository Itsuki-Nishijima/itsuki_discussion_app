class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board

  has_one_attached :eyecatch

  has_many :comments
end
