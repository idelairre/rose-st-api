class AddIdentifierToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :identifier, :string
  end
end
