class AddDescriptionToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :description, :string, limit: 1_024
  end
end
