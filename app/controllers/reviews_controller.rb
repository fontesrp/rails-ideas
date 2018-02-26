class ReviewsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_idea

  def create

    @review = Review.new review_params
    @review.idea = @idea
    @review.user = current_user

    if @review.save
      redirect_to idea_path(@idea)
    else
      render 'ideas/show'
    end
  end

  def destroy

    review = Review.find params.require(:id)
    alert = nil

    if can? :manage, review
      review.destroy
    else
      alert = "Access denied"
    end

    redirect_to idea_path(@idea), alert: alert
  end

  private

  def review_params
    params.require(:review).permit(:body)
  end

  def find_idea
    @idea = Idea.find params.require(:idea_id)
  end
end
