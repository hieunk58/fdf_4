class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  private
  def admin_user
    redirect_to root_path unless current_user.is_admin?
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:danger] = t "user.authorization.message"
      redirect_to signin_url
    end
  end
end
