class ChargesController < ApplicationController

  def new
  end

  def create
    token = params[:stripeToken]

    Stripe::Charge.create({
          :amount => params[:amount],
          :currency => "usd",
          :source => token
          })

    redirect_to :back

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
