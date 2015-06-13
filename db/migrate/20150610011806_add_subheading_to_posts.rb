class AddSubheadingToPosts < ActiveRecord::Migration
  def change
      add_column :posts, :subheading, :string
  end
end
