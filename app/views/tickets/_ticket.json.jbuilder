json.extract! ticket, :id, :title, :incident_description, :creation_date, :resolution_date, :response_to_user_date, :priority, :state, :resolution_key, :response_key, :response_to_user, :accept_or_reject_solution, :star_number, :limit_time_response, :limit_time_resolution, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
