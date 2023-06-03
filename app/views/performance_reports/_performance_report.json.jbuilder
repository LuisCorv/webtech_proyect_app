json.extract! performance_report, :id, :report_date, :user_id, :created_at, :updated_at
json.url performance_report_url(performance_report, format: :json)
