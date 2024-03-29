class CreateLike < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :voter, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps

      t.index [:voter_id, :post_id], unique: true
    end
  end
end