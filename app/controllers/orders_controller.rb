class OrdersController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    order = Order.create!(product: product, product_sku: product.sku, amount: product.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: product.sku,
        images: [product.photo],
        amount: product.price_cents,
        currency: 'usd',
        quantity: 1
      }],
      success_url: product_order_url(product, order),
      cancel_url: product_order_url(product, order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_product_order_payment_path(product, order)
  end

  def show
    @order = Order.find(params[:id])
  end

end
