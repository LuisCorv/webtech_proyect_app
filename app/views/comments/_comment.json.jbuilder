json.extract! comment, :id, :text, :writer, :chat_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
