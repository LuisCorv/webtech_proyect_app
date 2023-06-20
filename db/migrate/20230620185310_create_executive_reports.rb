class CreateExecutiveReports < ActiveRecord::Migration[7.0]
  def change
    create_table :executive_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :star_number
      t.integer :open_tickets
      t.integer :closed_tickets
      t.integer :created_tickets
      t.references :performance_report, foreign_key: true

      t.timestamps
    end
  end
end
