require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.create :user }

  describe 'validations' do

    it 'first name must be present' do
      user.first_name = nil
      user.valid?
      expect(user.errors).to have_key(:first_name)
    end

    it 'last name must be present' do
      user.last_name = nil
      user.valid?
      expect(user.errors).to have_key(:last_name)
    end

    it 'has unique email' do
      new_user = FactoryBot.create :user
      user.email = new_user.email
      user.valid?
      expect(user.errors).to have_key(:email)
    end

    it 'full_name method must return first_name and last_name concatenated & titleized' do
      user.first_name = 'snoop'
      user.last_name = 'dogg'
      expect(user.full_name).to eql('Snoop Dogg')
    end
  end
end
