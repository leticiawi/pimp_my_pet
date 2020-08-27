class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :new, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def show
    # @product = Product.find(params[:id])
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

  def edit
    # @product = Product.find(params[:id])
  end

  def update
    # @product = Product.find(params[:id])
    @product.update(product_params)
    product.save
    redirect_to product_path(@product)
  end

  def destroy
    # @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :photo)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
