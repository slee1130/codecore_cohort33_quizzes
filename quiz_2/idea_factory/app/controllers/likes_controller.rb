class LikesController < ApplicationController


    def create
        idea = Idea.find(params[:idea_id])
        like = Like.new(user: current_user, idea:idea)
        if !can?(:like, idea)
            redirect_to idea, alert: 'cannot like your own idea'
        elsif like.save
            flash[:success] = "Idea Liked"
        else
            flash[:danger] = like.errors.full_messages.join(",")
            redirect_to idea_path(idea)
        end
    end

  def destroy
    like = current_user.likes.find(params[:id])
    if  can? :destroy, like
      like.destroy
      flash[:success] = "Idea unliked"
      redirect_to idea_path(like.idea)
    else
      flash[:danger] = "Can't delete like"
      redirect_to idea_path(like.idea)
    end
  end
end
