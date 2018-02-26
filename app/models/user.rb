class User < ApplicationRecord

  has_secure_password

  has_many :ideas, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end
end
