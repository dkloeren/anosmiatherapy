class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order("created_at DESC")
  end

  def create
    product = Product.find(params[:product_id])
    order  = Order.create!(product: product, product_sku: product.sku, amount: product.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: product.name,
        images: [product.photo.url],
        amount: product.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: "http://www.anosmiatherapy.com/order/#{order.id}/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "http://www.anosmiatherapy.com/order/#{order.id}/cancel?session_id={CHECKOUT_SESSION_ID}"
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    customer = Stripe::Customer.retrieve(session.customer)
    @order = current_user.orders.find(params[:id])
  end
end
