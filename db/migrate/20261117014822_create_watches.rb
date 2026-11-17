class CreateWatches < ActiveRecord::Migration[8.1]
  def change
    create_table :watches do |t|
      t.string :brand
      t.string :model
      t.decimal :price

      t.timestamps
    end
  end
end
