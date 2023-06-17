class Ticket < ApplicationRecord

    has_many_attached :files, dependent: :destroy

    before_create :set_dates

    has_one :ticket_list, dependent: :destroy
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
        Low: 0,
        Normal: 1,
        High: 2,
        Urgent: 3
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


    def tag_listing
        tags.map{ |t| "✨  "+t.name+"  ✨"}
    end

    def set_dates
        self.creation_date=DateTime.current.beginning_of_day
        self.response_to_user_date=DateTime.current.beginning_of_day
        self.resolution_date=DateTime.current.beginning_of_day
        self.limit_time_response=DateTime.current.beginning_of_day
        self.limit_time_resolution=DateTime.current.beginning_of_day
    end
end
