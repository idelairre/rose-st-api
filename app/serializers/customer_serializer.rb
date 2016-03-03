class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :email, :subscriptions, :created_at

  def created_at
    object.created
  end

  def subscriptions
    object.subscriptions.total_count
  end
end

#<Stripe::Customer id=cus_7zgwqmtqmkclGw 0x00000a> JSON: {
#   "id": "cus_7zgwqmtqmkclGw",
#   "object": "customer",
#   "account_balance": 0,
#   "created": 1456715951,
#   "currency": "usd",
#   "default_source": "card_17jhYxCG2kj81Vpa5gQPGSXw",
#   "delinquent": false,
#   "description": null,
#   "discount": null,
#   "email": "johnny@appleseed.com",
#   "livemode": false,
#   "metadata": {
#   },
#   "shipping": null,
#   "sources": {
#     "object": "list",
#     "data": [
#       {
#         "id": "card_17jhYxCG2kj81Vpa5gQPGSXw",
#         "object": "card",
#         "address_city": null,
#         "address_country": null,
#         "address_line1": null,
#         "address_line1_check": null,
#         "address_line2": null,
#         "address_state": null,
#         "address_zip": null,
#         "address_zip_check": null,
#         "brand": "Visa",
#         "country": "US",
#         "customer": "cus_7zgwqmtqmkclGw",
#         "cvc_check": "pass",
#         "dynamic_last4": null,
#         "exp_month": 9,
#         "exp_year": 2018,
#         "funding": "credit",
#         "last4": "4242",
#         "metadata": {
#         },
#         "name": null,
#         "tokenization_method": null
#       }
#     ],
#     "has_more": false,
#     "total_count": 1,
#     "url": "/v1/customers/cus_7zgwqmtqmkclGw/sources"
#   },
#   "subscriptions": {
#     "object": "list",
#     "data": [
#
#     ],
#     "has_more": false,
#     "total_count": 0,
#     "url": "/v1/customers/cus_7zgwqmtqmkclGw/subscriptions"
#   }
# }
