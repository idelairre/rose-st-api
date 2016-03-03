class ChargeSerializer < ActiveModel::Serializer
  attributes :id, :amount, :customer, :created_at

  def customer
    object.source.name
  end

  def created_at
    object.created
  end
end

#<Stripe::Charge id=ch_17jm3LCG2kj81Vpa0mAQNkbj 0x00000a> JSON: {
#   "id": "ch_17jm3LCG2kj81Vpa0mAQNkbj",
#   "object": "charge",
#   "amount": 3213,
#   "amount_refunded": 0,
#   "application_fee": null,
#   "balance_transaction": "txn_17jhMoCG2kj81VpaMeKcRUun",
#   "captured": true,
#   "created": 1456733211,
#   "currency": "usd",
#   "customer": null,
#   "description": null,
#   "destination": null,
#   "dispute": null,
#   "failure_code": null,
#   "failure_message": null,
#   "fraud_details": {
#   },
#   "invoice": null,
#   "livemode": false,
#   "metadata": {
#   },
#   "order": null,
#   "paid": true,
#   "receipt_email": null,
#   "receipt_number": null,
#   "refunded": false,
#   "refunds": {
#     "object": "list",
#     "data": [
#
#     ],
#     "has_more": false,
#     "total_count": 0,
#     "url": "/v1/charges/ch_17jm3LCG2kj81Vpa0mAQNkbj/refunds"
#   },
#   "shipping": null,
#   "source": {
#     "id": "card_17jm3HCG2kj81VpatkQc4hL1",
#     "object": "card",
#     "address_city": null,
#     "address_country": null,
#     "address_line1": null,
#     "address_line1_check": null,
#     "address_line2": null,
#     "address_state": null,
#     "address_zip": null,
#     "address_zip_check": null,
#     "brand": "Visa",
#     "country": "US",
#     "customer": null,
#     "cvc_check": "pass",
#     "dynamic_last4": null,
#     "exp_month": 12,
#     "exp_year": 2016,
#     "funding": "credit",
#     "last4": "4242",
#     "metadata": {
#     },
#     "name": "idelairre@gmail.com",
#     "tokenization_method": null
#   },
#   "source_transfer": null,
#   "statement_descriptor": null,
#   "status": "succeeded"
# }
