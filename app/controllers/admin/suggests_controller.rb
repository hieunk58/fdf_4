class Admin::SuggestsController < ApplicationController
  before_action :find_suggest, only:[:destroy]

  def index
    @suggests = Suggest.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t "application.flash.comments.destroy_success"
    else
      flash[:danger] = t "application.flash.comments.no_destroy"
    end
    redirect_to admin_suggests_path
  end

  private
  def find_suggest
    @suggest = Suggest.find_by id: params[:id]
  end
end
