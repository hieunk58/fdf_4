class Admin::UsersController < ApplicationController
  before_action :signed_in_user, :admin_user
  before_action :load_user, only: [:show, :edit, :update]

  def show
  end

  def index
    @users = User.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.edit.profile_updated"
      redirect_to admin_users_path
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

end
