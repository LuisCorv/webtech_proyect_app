json.extract! ticket_list, :id, :user_id, :ticket_id, :created_at, :updated_at
json.url ticket_list_url(ticket_list, format: :json)
