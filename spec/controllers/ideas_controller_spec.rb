require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  let(:user) { FactoryBot.create :user }

  describe '#new' do

    context 'user signed in' do

      before do
        request.session[:user_id] = user.id
        get :new
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'set an instance variable with a new idea' do
        expect(assigns(:idea)).to be_a_new(Idea)
      end
    end

    context 'user not signed in' do

      it 'redirects to sign in page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe '#create' do

    context 'user signed in' do

      before { request.session[:user_id] = user.id }

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

      context 'with invalid parameters' do

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

    context 'user not signed in' do
      it 'redirects to sign in page' do
        get :create
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe '#edit' do

    def get_request
      @idea = FactoryBot.create :idea, user: user
      get :edit, params: { id: @idea.id }
    end

    context 'user signed in' do

      before { request.session[:user_id] = user.id }

      context 'user is the owner of the idea' do

        it "renders the edit template" do
          get_request
          expect(response).to render_template :edit
        end

        it "sets an instance variable based on the article id that is passed" do
          get_request
          expect(assigns(:idea)).to eq(@idea)
        end
      end

      context 'user is not the owner of the idea' do

        before do
          @another_idea = FactoryBot.create :idea
          get :edit, params: { id: @another_idea.id }
        end

        it 'redirects the the idea show page' do
          expect(response).to redirect_to(idea_path(@another_idea))
        end

        it 'alerts the user with a flash' do
          expect(flash[:alert]).to be
        end
      end
    end

    context 'user not signed in' do
      it 'redirects to sign in page' do
        get_request
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe '#update' do

    before { @idea = FactoryBot.create :idea, user: user }

    context 'user signed in' do

      before { request.session[:user_id] = user.id }

      context 'user is the owner of the idea' do

        context 'with valid parameters' do

          it "updates the idea record with new attributes" do

            new_title = "#{@idea.title} Plus Changes!"
            patch :update, params: { id: @idea.id, idea: { title: new_title } }
            @idea.reload

            expect(@idea.title).to eq(new_title)
          end

          it "redirect to the idea show page" do

            new_title = "#{@idea.title} plus changes!"
            patch :update, params: {id: @idea.id, idea: {title: new_title}}

            expect(response).to redirect_to(@idea)
          end
        end

        context 'with invalid parameters' do

          def invalid_request
            patch :update, params: {id: @idea.id, idea: { title: nil } }
          end

          it "doesn't update the idea with new attributes" do
            expect { invalid_request }.not_to change { @idea.reload.title }
          end

          it "renders the edit template" do
            invalid_request
            expect(response).to render_template(:edit)
          end
        end
      end

      context 'user is not the owner of the idea' do

        before do
          @another_idea = FactoryBot.create :idea
          patch :update, params: { id: @another_idea.id, idea: { title: "#{@idea.title} Plus Changes!" } }
        end

        it 'redirects the idea show page' do
          expect(response).to redirect_to(idea_path(@another_idea))
        end

        it 'alerts the user with a flash' do
          expect(flash[:alert]).to be
        end
      end
    end

    context 'user not signed in' do
      it 'redirects to sign in page' do
        patch :update, params: { id: @idea.id, idea: { title: "#{@idea.title} Plus Changes!" } }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe '#show' do

    before do
      @idea = FactoryBot.create(:idea)
      get :show, params: { id: @idea.id }
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets an instance variable based on the article id that is passed" do
      expect(assigns(:idea)).to eq(@idea)
    end
  end

  describe '#index' do

    before { get :index }

    it "renders the index template" do
      expect(response).to render_template(:index)
    end

    it "assigns an instance variable to all created ideas (sorted by created_at)" do
      idea_1 = FactoryBot.create(:idea)
      idea_2 = FactoryBot.create(:idea)
      expect(assigns(:ideas)).to eq([idea_2, idea_1])
    end
  end

  describe '#destroy' do

    before { @idea = FactoryBot.create(:idea, user: user) }

    def delete_request
      delete :destroy, params: { id: @idea.id }
    end

    context 'user signed in' do

      before { request.session[:user_id] = user.id }

      context 'user is the owner of the idea' do

        it 'removes a record from the database' do

          count_before = Idea.count
          delete_request
          count_after = Idea.count

          expect(count_after).to eq(count_before - 1)
        end

        it 'redirects to the root' do
          delete_request
          expect(response).to redirect_to root_path
        end
      end

      context 'user is not the owner of the idea' do

        before do
          @another_idea = FactoryBot.create :idea
          delete :destroy, params: { id: @another_idea.id }
        end

        it 'redirects the idea show page' do
          expect(response).to redirect_to(idea_path(@another_idea))
        end

        it 'alerts the user with a flash' do
          expect(flash[:alert]).to be
        end
      end
    end

    context 'user not signed in' do
      it 'redirects to sign in page' do
        delete_request
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
