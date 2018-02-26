class IdeasController < ApplicationController

  before_action :find_idea, only: [:edit, :show, :update, :destroy]

  def index
    @ideas = Idea.all.order created_at: :DESC
  end

  def create

    @idea = Idea.create idea_params

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
end
