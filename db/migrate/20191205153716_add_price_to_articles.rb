class AddPriceToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :price, :decimal, precision: 7, scale: 2
  end
end
