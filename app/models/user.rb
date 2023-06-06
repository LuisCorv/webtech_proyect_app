class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :ticket_lists, dependent: :destroy
    has_many :assign_tickets, dependent: :destroy
    has_many :performance_reports


    enum :profile, {
        User: 0,
        Executive: 1,
        Supervisor: 2,
        Administrator: 3
      }

      validates :name, presence: true
      validates :last_name, presence: true
      validates :phone, presence: true
end
