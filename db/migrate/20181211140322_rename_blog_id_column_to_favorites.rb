class RenameBlogIdColumnToFavorites < ActiveRecord::Migration[5.1]
  def change
    rename_column :favorites, :blog_id, :post_id
  end
end
