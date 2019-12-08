class CreateJoinTableArticleStore < ActiveRecord::Migration[6.0]
  def change
    create_join_table :articles, :stores do |t|
      # t.index [:article_id, :store_id]
      # t.index [:store_id, :article_id]
    end
  end
end
