require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  let(:idea) { FactoryBot.create :idea }

  describe '#new' do

    before { get :new }

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'set an instance variable with a new idea' do
      expect(assigns(:idea)).to be_a_new(Idea)
    end
  end

  describe '#create' do

    context 'with valid parameters' do

      def valid_request
        post :create, params: {
          idea: FactoryBot.attributes_for(:idea)
        }
      end

      it 'creates a idea in the db' do

        qtt_before = Idea.count
        valid_request
        qtt_after = Idea.count

        expect(qtt_after).to eql(qtt_before + 1)
      end

      it "redirects to the new idea's show page" do

        valid_request

        expect(response).to redirect_to(idea_path(Idea.last))
      end
    end

    context 'without valid parameters' do

      def invalid_request
        post :create, params: {
          idea: FactoryBot.attributes_for(:idea, title: nil)
        }
      end

      it 'does not create a new idea in the db' do

        qtt_before = Idea.count
        invalid_request
        qtt_after = Idea.count

        expect(qtt_after).to eql(qtt_before)
      end

      it 'renders the new template' do

        invalid_request

        expect(response).to render_template(:new)
      end
    end
  end
end
