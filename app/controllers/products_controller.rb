class ProductsController < ApplicationController
  #skip_before_action :authenticate_user!, only: :index, :new
  #before_action :set_product, only: [:show, :destroy, :index]

  def new
    @product = Product.new
  end

  def show
    @user = User.new
    @product = Product.new
    @products = Product.find(params[:id])
  end

  def index
    @products = Product.all
    #@selected_products = @products.select { |product| product.category }
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :photo)
  end

end
