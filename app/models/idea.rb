class Idea < ApplicationRecord

    validates :title, :description, presence: true
end
