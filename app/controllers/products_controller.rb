class ProductsController < ApplicationController
  def index
    @products = Product.all
    if params[:product_name].present?
      @products = @products.product_name params[:product_name]
    end
    @products = @products.price params[:price] if params[:price].present?
    if @products.present?
      @products.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.per_page
    end
    if params[:product_name].blank? && params[:price].blank?
      @products = Product.all
        .order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.per_page
    end
    @products = @products.order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @product = Product.find_by id: params[:id]
    if @product.nil?
      flash[:danger] = t "flash.no_image"
      redirect_to products_path
    end
    @comments = @product.comments.order(created_at: :desc).paginate page:
      params[:page], per_page: Settings.per_page
    @comment = Comment.new
  end
end
