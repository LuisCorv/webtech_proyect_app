class RemoveUserReferenceFromPerformanceReports < ActiveRecord::Migration[7.0]
  def change
    remove_reference :performance_reports, :user, null: false, foreign_key: true
  end
end
