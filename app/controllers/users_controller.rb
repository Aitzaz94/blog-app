class UsersController < ApplicationController
    before_action :authenticate_user!
    after_action :verify_authorized
  
    def index
      @users = User.all
      authorize User
    end
  
    def show
      @user = User.find(params[:id])
      authorize @user
    end
  
    def update
      @user = User.find(params[:id])
      authorize @user
      if @user.update(secure_params)
        redirect_to users_path, :success => "User updated."
      else
        redirect_to users_path, :danger => "Unable to update user."
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      authorize @user
      @user.destroy
      redirect_to users_path, :danger => "User deleted."
    end
  
    private
  
    def secure_params
      params.require(:user).permit(:role, :image)
    end
  
  end