require 'rails_helper'

RSpec.describe Idea, type: :model do

  let(:idea) { FactoryBot.create :idea }

  describe 'validations' do

    it 'title must be present' do
      idea.title = nil
      idea.valid?
      expect(idea.errors).to have_key(:title)
    end

    it 'description must be present' do
      idea.description = nil
      idea.valid?
      expect(idea.errors).to have_key(:description)
    end

    it 'user must be present' do
      idea.user = nil
      idea.valid?
      expect(idea.errors).to have_key(:user)
    end
  end
end
