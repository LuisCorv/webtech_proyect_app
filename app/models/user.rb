class User < ApplicationRecord

    has_many :ticket_lists
    has_many :assign_tickets


    enum :profile, {
        User: 0,
        Executive: 1,
        Supervisor: 2,
        Administrator: 3
      }

      
      validates :name, presence: true
      validates :last_name, presence: true
      validates :phone, presence: true
      validates :password, presence: true
end
