class AddColumnsToPerformanceReports < ActiveRecord::Migration[7.0]
  def change
    add_column :performance_reports, :wanted_year, :integer
    add_column :performance_reports, :wanted_month, :integer
  end
end
