class CreateAdminmessages < ActiveRecord::Migration[5.2]
  def change
    create_table :adminmessages do |t|
      t.string :message
      t.references :staff, foreign_key: true

      t.timestamps
    end
  end
end
