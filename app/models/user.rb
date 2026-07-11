class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :avatar

  validates :name,
            presence: true,
            length: { maximum: 20 }

  validates :profile,
            length: { maximum: 300 },
            allow_blank: true
end
