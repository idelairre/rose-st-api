class TransactionSerializer < ActiveModel::Serializer
  attributes :amount, :available_on, :created_at, :fee, :id, :net, :source, :type
  
  def created_at
    object.created
  end
end
