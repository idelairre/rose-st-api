class ChargesController < ApplicationController
  def new
  end

  def create
    token = params[:token]

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

  private

  def charge_params
    params.permit(:token)
  end
end
