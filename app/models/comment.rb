class Comment < ApplicationRecord
  belongs_to :chat
  validates :text, presence: true
  validates :writer, presence: true
end
