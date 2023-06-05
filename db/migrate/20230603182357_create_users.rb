class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false
      t.integer :profile, null: false, default: 0
      

      t.timestamps
    end
  end
end
