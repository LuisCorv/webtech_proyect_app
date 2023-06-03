class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.string :writer, null: false
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
