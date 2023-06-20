class ExecutiveReport < ApplicationRecord
  belongs_to :user
  belongs_to :performance_report
  
  after_create :set_data

  def set_data
    year=self.performance_report.wanted_year

    if not self.performance_report.wanted_month.nil?
      month=self.performance_report.wanted_month

      self.created_tickets=Ticket.joins(:ticket_list).where("ticket_lists.user_id = ?  AND EXTRACT(YEAR FROM tickets.creation_date) = ? AND EXTRACT(MONTH FROM tickets.created_at) = ?", self.user.id, year, month).count

      close_assign=Ticket.joins(:assign_ticket).where("assign_tickets.user_id = ? AND tickets.state=2 AND EXTRACT(YEAR FROM tickets.creation_date) = ? AND EXTRACT(MONTH FROM tickets.created_at) = ?", self.user.id, year, month)

      self.closed_tickets=close_assign.count()
      self.star_number=close_assign.sum(:star_number)

      self.open_tickets=Ticket.joins(:assign_ticket).where("assign_tickets.user_id = ? AND (tickets.state=1 OR tickets.state=3)  AND EXTRACT(YEAR FROM tickets.creation_date) = ? AND EXTRACT(MONTH FROM tickets.created_at) = ?", self.user.id, year, month).count()

    else
      self.created_tickets=Ticket.joins(:ticket_list).where("ticket_lists.user_id = ?  AND EXTRACT(YEAR FROM tickets.creation_date) = ?", self.user.id, year).count

      close_assign=Ticket.joins(:assign_ticket).where("assign_tickets.user_id = ? AND tickets.state=2 AND EXTRACT(YEAR FROM tickets.creation_date) = ?", self.user.id, year)

      self.closed_tickets=close_assign.count()
      self.star_number=close_assign.sum(:star_number)

      self.open_tickets=Ticket.joins(:assign_ticket).where("assign_tickets.user_id = ? AND (tickets.state=1 OR tickets.state=3)  AND EXTRACT(YEAR FROM tickets.creation_date) = ?", self.user.id, year).count()

    end

    
    self.save
  end

  def star_avarage
    if  self.star_number >0
      self.star_number/ self.closed_tickets
    else
      self.star_number
    end
  end

end
