class ReviewsController < ApplicationController
    before_action :authenticate_user!

    def create
        @idea = Idea.find params[:idea_id]
        @review = Review.new review_params
        @review.idea = @idea
        @review.user = current_user

        if @review.save
            redirect_to idea_path(@idea)
        else
            @reviews = @idea.reviews.order(created_at: :desc)
            render 'ideas/show'
        end
    end

    def destroy
        @idea = Idea.find params[:idea_id]
        @review = Review.find params[:id]
        @review.destroy
        redirect_to idea_path(@idea),
        notice: 'Review Deleted'
    end

    private

    def review_params
        params.require(:review).permit(:body)
    end

end
