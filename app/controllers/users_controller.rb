class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :load_user, :correct_user, only: [:show, :edit, :update]

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if  @user.save
      flash[:success] = t "flash.message"
      redirect_to @user
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.edit.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email,
      :address, :phone, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end
end
