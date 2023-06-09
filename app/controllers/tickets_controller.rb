class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new

    if current_user.Supervisor? or current_user.Administrator?
      redirect_to user_tickets_path(current_user), alert: "You can't create Tickets, only Users and Executives can."
      return
    elsif current_user.Executive? and  not params[:check_location].present?
      redirect_to user_tickets_path(current_user), alert: "You can only created tickets from your ticket list"
      return
    
    elsif  current_user.User? 
      redirect_to user_tickets_path(current_user), alert: "You can't created tickets this way, you can only make them from your ticket list"
      return
    end

    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit

  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    
    @ticket.files.attach(params[:ticket][:new_files]) if params[:ticket][:new_files].present?
    
      if @ticket.save
        Chat.create(ticket:@ticket)
        TagList.create(ticket:@ticket)

        if current_user.Executive? 
             # crear TicketList y luego hacer el siguiente paso
            ticket_list=TicketList.create(user:current_user, ticket: @ticket)
           
            redirect_to user_ticket_list_ticket_path(current_user,ticket_list,@ticket), notice: "Ticket was successfully created." 
 
        elsif current_user.User?
          # crear TicketList y luego hacer el siguiente paso
          ticket_list=TicketList.create(user:current_user, ticket: @ticket)
          
          redirect_to user_ticket_list_ticket_path(current_user,ticket_list,@ticket), notice: "Ticket was successfully created."
        end
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update

    
      if @ticket.update(ticket_params)
        @ticket.files.attach(params[:ticket][:new_files]) if params[:ticket][:new_files].present?

        if current_user.Executive? 
          assign_or_list=(params[:ticket][:assign_list_nothing]).split(" ")
          if assign_or_list[0]=="assign"
            redirect_to user_assign_ticket_ticket_path(current_user,@ticket.assign_ticket,@ticket), notice: "Ticket was successfully created." 
            return
          elsif assign_or_list[0]=="list"
            redirect_to user_ticket_list_ticket_path(current_user,@ticket.ticket_list,@ticket), notice: "Ticket was successfully created." 
            return
          end  
        elsif current_user.User?
          redirect_to user_ticket_list_ticket_path(current_user,@ticket.ticket_list,@ticket), notice: "Ticket was successfully created."
          return
        
        elsif current_user.Supervisor? or current_user.Administrator?
          redirect_to user_ticket_path(current_user,@ticket), notice: "Ticket was successfully created."
          return
        end
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    #Check that when is executive and assign_ticket, it can't delete the ticket
    @assig=session[:assign]
    if current_user.Executive?  and @assig=="yes"
      redirect_to user_assign_ticket_ticket_path(current_user,@ticket.assign_ticket,@ticket), alert: "You can't delete a ticket if it's your assign ticket"
      return
    end
    @ticket.chat.comments.destroy_all
    @ticket.chat.destroy
    @ticket.tag_list.tags.destroy_all
    @ticket.tag_list.destroy
    if not  @ticket.assign_ticket.nil?
      @ticket.assign_ticket.destroy
    end
    @ticket.ticket_list.destroy

    @ticket.destroy



    if current_user.Executive? 
      redirect_to user_ticket_lists_path(current_user), notice: "Ticket was successfully destroyed." 
      return
    elsif current_user.User?
      redirect_to user_ticket_lists_path(current_user), notice: "Ticket was successfully destroyed."
      return
    elsif current_user.Supervisor? or current_user.Administrator?
      redirect_to user_tickets_path(current_user), notice: "Ticket was successfully destroyed."
      return
    end
  end


  def ticket_report
    if  not current_user.Supervisor? and  not current_user.Administrator?
      redirect_to user_tickets_path(current_user), alert: "You can't access the ticket report"
      return
    end

  end

  def overdue_report
    if  not current_user.Supervisor? and  not current_user.Administrator?
      redirect_to user_tickets_path(current_user), alert: "You can't access the overdue report"
      return
    end
  end

  def search
    @query = params[:query]
    @ticket_title =Ticket.joins(ticket_list: :user).where("tickets.title ILIKE :query OR tickets.incident_description ILIKE :query OR users.email ILIKE :query", query: "%#{@query}%")
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:title, :incident_description, :creation_date, :resolution_date, :response_to_user_date, :priority, :state, :resolution_key, :response_key, :response_to_user, :accept_or_reject_solution, :star_number, :limit_time_response, :limit_time_resolution)
    end
end
