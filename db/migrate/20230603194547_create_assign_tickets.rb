class CreateAssignTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :assign_tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
