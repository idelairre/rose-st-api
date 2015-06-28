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

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  def subscription
    customer = Stripe::Customer.create(
      :source => params[:token]
    )
    customer.subscriptions.create(:plan => params[:subscription_id])
  end

  def custom_subscription
    customer = Stripe::Customer.create(
      :source => params[:token]
    )
    plan = Stripe::Plan.create( :amount => params[:amount], :interval => 'month', :name => "Monthly Donation Plan for #{customer.id}", :currency => 'usd', :id => Stripe::Plan.all.data.length + 1 )
    customer.subscriptions.create(:plan => plan[:id])
  end

  private

  def charge_params
    params.permit(:token)
  end
end
