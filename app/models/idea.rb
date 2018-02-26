class Idea < ApplicationRecord

  belongs_to :user

  has_many :reviews, dependent: :destroy

  validates :title, :description, presence: true
end
