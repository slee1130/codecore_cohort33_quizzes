class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :show, :update, :password]
    before_action :authorize!, only: [:edit, :update, :password]

    def new
        @user = User.new
    end

  def create
        @user = User.new user_params

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path

        else
            render :new
        end
    end


    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password,:password_confirmation)
    end

    def find_user
        @user = User.find params[:id]
    end

    def authorize!
        redirect_to root_path, alert: 'Not authorized!' unless can?(:crud, current_user)
    end


end
