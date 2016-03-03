class DonationsController < ApplicationController
  before_action :authenticate_user!, only: [:list_active_subscriptions, :list_charges, :list_customers, :list_transactions]

  def list_active_subscriptions
    customer_subscriptions = []
    customer_ids = []
    customers = Stripe::Customer.all(:limit => 50)
    customers.each do |customer|
      customer_subscriptions.push(customer.subscriptions)
    end
    @subscriptions = customer_subscriptions.map do |subscriptions|
      if subscriptions.data != []
        subscriptions = subscriptions.data.to_a
        subscriptions.map do |sub|
          sub = sub
        end
      end
    end
    @subscriptions.flatten!.compact!
    render json: @subscriptions, each_serializer: SubscriptionSerializer
  end

  def list_charges
    charges = Stripe::Charge.all(:limit => 50)
    @charges = charges.data
    render json: @charges, each_serializer: ChargeSerializer
    # render json: @charges.as_json(:only => [:id, :object, :amount, :source, :created, :name]), status: 200
  end

  def list_transactions
    transactions = Stripe::BalanceTransaction.all(:limit => 50)
    @transactions = transactions.data
    render json: @transactions, each_serializer: TransactionSerializer
  end

  def list_customers
    customers = Stripe::Customer.all(:limit => 50)
    @customers = customers.data
    render json: @customers, each_serializer: CustomerSerializer
  end

  def new
  end

  def create
    token = params[:token]
    charge = Stripe::Charge.create({:amount => params[:amount], :currency => 'usd', :source => token })

  rescue Stripe::CardError,
    Stripe::APIConnectionError,
    Stripe::APIError,
    Stripe::InvalidRequestError => e
      Utility.log_exception(e, { :info => 'error during #create'} )
  end

  def subscription
    customer = Stripe::Customer.create(:source => params[:token])
    customer.subscriptions.create(:plan => params[:subscription_id])

  rescue Stripe::CardError,
    Stripe::APIConnectionError,
    Stripe::APIError,
    Stripe::InvalidRequestError => e
      Utility.log_exception(e, { :info => 'error during #subscription'} )
  end

  def custom_subscription
    customer = Stripe::Customer.create(:source => params[:token])
    plan = Stripe::Plan.create(
      :amount => params[:amount],
      :interval => 'month',
      :name => 'Monthly Donation Plan for #{customer.id}',
      :currency => 'usd',
      :id => Stripe::Plan.all.data.length + 1
    )
    customer.subscriptions.create(:plan => plan[:id])

  rescue Stripe::CardError,
    Stripe::APIConnectionError,
    Stripe::APIError,
    Stripe::InvalidRequestError => e
      Utility.log_exception(e, { :info => 'error during #custom_subscription'} )
  end

  private

  def donation_params
    params.permit(:amount, :token)
  end
end
