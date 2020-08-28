class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def show
    # @product = Product.find(params[:id])
  end

  def index
    if params[:search].present?
      @products = Product.where(category: params[:search])
    else
      @products = Product.all
    end

    if params[:search] == "toys"
      @background = "https://images.unsplash.com/photo-1514984879728-be0aff75a6e8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3076&q=80"
      @title = "Toys"
    elsif params[:search] == "treats"
      @background = "https://i.ibb.co/H7mWW03/treat-banner-2.jpg"
      @title = "Treats"
    elsif params[:search] == "beauty"
      @background = "https://i.ibb.co/M8nLwPQ/bannerbeauty.jpg"
      @title = "Beauty"
    else
      @background = "https://images.unsplash.com/photo-1516453734593-8d198ae84bcf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80"
      @title = "All products"
    end


    @products = @products.reject{ |product| product.orders.count.positive? }

  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    @product.price_cents = @product.price_cents * 100
    @product.sku = @product.name.parameterize


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
    if @product.save
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    # @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_cents, :photo, :category)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
