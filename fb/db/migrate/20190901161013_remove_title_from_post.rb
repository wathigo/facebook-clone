class RemoveTitleFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :title, :text
  end
end
