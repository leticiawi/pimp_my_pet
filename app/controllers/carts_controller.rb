class CartsController < ApplicationController
  def index
    @carts = current_user.carts
  end

  def new
    @cart = Cart.new
    @product = Product.find(params[:product_id])
  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      redirect_to cart_path(@cart)
    end
  end

  def show
    @cart = Cart.find(params[:id])
    @product = @cart.product
  end

  def destroy
  end

end
