class IdeasController < ApplicationController

    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    # before_action :authenticate_user!, only: [:new]
    before_action :authenticate_user!, expect: [:new,:index]

    def new
        @idea = Idea.new
        render :new
    end

    def create
        @idea = Idea.new idea_params
        @idea.user = current_user
        if @idea.save
            flash[:notice] = "Idea created successfully"
            redirect_to idea_path(@idea)
        else
            render :new
        end
    end

    def show
        @idea = Idea.find(params[:id])
        @reviews = @idea.reviews
        @review = Review.new
        @like = @idea.likes.find_by(user:current_user)
    end

    def index
        @ideas = Idea.all.sort_by { |idea| idea.description }
    end

    def update
        if @idea.update idea_params
            redirect_to idea_path(@idea)
        else
            render :show
        end
    end

    def destroy
        @idea.destroy
        redirect_to ideas_path
    end

    def liked
    @ideas = current_user.liked_ideas.order(created_at: :desc)
    end

    private

    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def find_idea
        @idea = Idea.find params[:id]
    end




end
