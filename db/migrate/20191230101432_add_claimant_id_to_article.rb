class AddClaimantIdToArticle < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :articles, :claimant, foreign_key: { to_table: :guests }
  end
end
