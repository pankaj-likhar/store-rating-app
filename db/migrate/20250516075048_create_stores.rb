class CreateStores < ActiveRecord::Migration[7.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :email
      t.string :address
      t.integer :owner_id

      t.timestamps
    end
  end
end
