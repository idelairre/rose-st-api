class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :customer, :created_at

  def amount
    object.plan.amount
  end

  def created_at
    object.plan.created
  end
end

#<Stripe::StripeObject id=sub_7wLkdwhmExiSOv 0x00000a> JSON: {
# {
#   "id": "sub_7wLozDHPFfeQWS",
#   "customer": "cus_7wLojmZaEVmzcv",
#   "object": {
#     "id": "sub_7wLozDHPFfeQWS",
#     "object": "subscription",
#     "application_fee_percent": null,
#     "cancel_at_period_end": false,
#     "canceled_at": null,
#     "current_period_end": 1458451022,
#     "current_period_start": 1455945422,
#     "customer": "cus_7wLojmZaEVmzcv",
#     "discount": null,
#     "ended_at": null,
#     "metadata": {},
#     "plan": {
#       "id": "3",
#       "object": "plan",
#       "amount": 4300,
#       "created": 1455945421,
#       "currency": "usd",
#       "interval": "month",
#       "interval_count": 1,
#       "livemode": false,
#       "metadata": {},
#       "name": "Monthly Donation Plan for cus_7wLojmZaEVmzcv",
#       "statement_descriptor": null,
#       "trial_period_days": null
#     },
#     "quantity": 1,
#     "start": 1455945422,
#     "status": "active",
#     "tax_percent": null,
#     "trial_end": null,
#     "trial_start": null
#   },
#   "created": 1455945421
# }
