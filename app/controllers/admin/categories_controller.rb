class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  before_action :load_category, except: [:index, :create]

  def index
    @categories = Category.includes(:products).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin.categories.create_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "admin.categories.create_error"
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :category_name
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
