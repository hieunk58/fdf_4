class Admin::CategoriesController < ApplicationController
  before_action :signed_in_user, :check_admin
  before_action :load_category, except: [:index, :create]

  def index
    @categories = Category.includes(:products).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end
asdfasdfasdfsadf
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

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.categories.update_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "admin.categories.delete_success"
    else
      flash[:danger] = t "admin.categories.delete_error"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :category_name
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
