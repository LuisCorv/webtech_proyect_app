class Ticket < ApplicationRecord

    has_one :ticket_list
    has_one :assign_ticket
    has_one :tag_list
    has_many :tags ,through: :tag_list
    has_one :chat
    has_many :comments ,through: :chat

    validates :title, presence:true
    validates :incident_description, presence: true
    validates :priority, presence: true
    validates :state, presence:true
    validates :star_number, numericality: {only_integer: true ,in: 0..6}

    enum :priority, {
        "Low Priority": 0,
        "Normal Priority": 1,
        "High Priority": 2,
        "Urgent Priority": 3
      }
    enum :state, {
        "Waiting State": 0,
        Open: 1,
        Closed: 2,
        ReOpen: 3
    }
    enum :resolution_key, {
        "Resolution Pending": 0,
        "Resolution Done": 1
    }
    enum :response_key, {
        "Response Pending": 0,
        "Response Done": 1
    }
    enum :accept_or_reject_solution, {
        Pending: 0,
        Accept: 1,
        Decline: 2
    }
end
