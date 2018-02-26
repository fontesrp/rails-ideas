class IdeasController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_idea, only: [:edit, :show, :update, :destroy]
  before_action :check_owner!, only: [:edit, :update, :destroy]

  def index
    @ideas = Idea.all.order created_at: :DESC
  end

  def create

    @idea = Idea.create idea_params
    @idea.user = current_user

    if @idea.save
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def new
    @idea = Idea.new
  end

  def edit
  end

  def show
    @review = Review.new
  end

  def update

    if @idea.update idea_params
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to root_path
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def find_idea
    @idea = Idea.find params.require(:id)
  end

  def check_owner!
      redirect_to idea_path(@idea), alert: "Access denied" unless can? :manage, @idea
  end
end
