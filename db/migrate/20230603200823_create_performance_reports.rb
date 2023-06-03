class CreatePerformanceReports < ActiveRecord::Migration[7.0]
  def change
    create_table :performance_reports do |t|
      t.datetime :report_date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
