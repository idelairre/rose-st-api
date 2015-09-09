class AddTitleUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :title_url, :string
  end
end
