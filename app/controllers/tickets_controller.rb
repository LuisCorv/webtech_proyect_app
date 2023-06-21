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
    
    elsif  current_user.User? and  not params[:check_location].present?
      # Ajustar esta parte para que userpueda crear tickets a trave de ticket_list
      redirect_to user_tickets_path(current_user), alert: "You can't created tickets this way, you can only make them from your ticket list"
      return
    end

    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit

    if (current_user.User? or current_user.Executive?) and (@ticket.star_number=!6 or @ticket.state=="Closed")
      redirect_to user_tickets_path(current_user), alert: "This ticket is Closed, so you can edit it, except if it its Re-Open"
    end

  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    
    
    @ticket.files.attach(params[:ticket][:new_files]) if params[:ticket][:new_files].present?
    
      if @ticket.save
        Chat.create(ticket:@ticket)
        TagList.create(ticket:@ticket)

        pre_assign_user=@ticket.pre_assing_executive
        if pre_assign_user ==current_user
          pre_assign_user=@ticket.pre_assing_second
        end

        AssignTicket.create(ticket: @ticket, user: pre_assign_user)


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
      parameter=ticket_params
      time_limit_hour="23:59:59.999999999"

      if (parameter[:limit_time_response].present?)
        if (parameter[:limit_time_response]!=@ticket.limit_time_response.to_date) and (parameter[:limit_time_resolution]!=@ticket.limit_time_resolution.to_date)
          parameter[:limit_time_response]= "#{parameter[:limit_time_response]} #{time_limit_hour}"
          parameter[:limit_time_resolution]= "#{parameter[:limit_time_resolution]} #{time_limit_hour}"

        elsif parameter[:limit_time_response]!=@ticket.limit_time_response.to_date
          
          parameter[:limit_time_response]= "#{parameter[:limit_time_response]} #{time_limit_hour}"

        elsif parameter[:limit_time_resolution]!=@ticket.limit_time_resolution.to_date

          parameter[:limit_time_resolution]= "#{parameter[:limit_time_resolution]} #{time_limit_hour}"

        end
      end


      if (parameter[:response_to_user].present?)
        if not parameter[:response_to_user].empty?
          parameter[:response_key]="Response Done"
          parameter[:response_to_user_date]=Time.current
        end
      end

      if (parameter[:accept_or_reject_solution].present?)
        if parameter[:accept_or_reject_solution]=="Accept"
          parameter[:state]="Closed"
        end
      end

      if (parameter[:state].present?)
        if parameter[:state]=="Closed"
          parameter[:resolution_key]="Resolution Done"
          parameter[:resolution_date]=Time.current
        end
      end
     
    
      if @ticket.update(parameter)
        @ticket.files.attach(params[:ticket][:new_files]) if params[:ticket][:new_files].present?

        if current_user.Executive? 
          assign_or_list=(params[:ticket][:assign_list_nothing]).split(" ")
          if assign_or_list[0]=="assign"
            redirect_to user_assign_ticket_ticket_path(current_user,@ticket.assign_ticket,@ticket), notice: "Ticket was successfully updated." 
            return
          elsif assign_or_list[0]=="list"
            redirect_to user_ticket_list_ticket_path(current_user,@ticket.ticket_list,@ticket), notice: "Ticket was successfully updated." 
            return
          end  
        elsif current_user.User?
          redirect_to user_ticket_list_ticket_path(current_user,@ticket.ticket_list,@ticket), notice: "Ticket was successfully updated."
          return
        
        elsif current_user.Supervisor? or current_user.Administrator?
          redirect_to user_ticket_path(current_user,@ticket), notice: "Ticket was successfully updated."
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

    @tickets = Ticket.where('(resolution_date > limit_time_resolution AND limit_time_resolution > creation_date ) 
    OR (response_to_user_date > limit_time_response AND limit_time_response > creation_date)  
    OR ((resolution_date = creation_date AND limit_time_resolution > creation_date AND limit_time_resolution < ?) 
    OR (response_to_user_date = creation_date  AND limit_time_response > creation_date AND  limit_time_response < ?))', Time.now, Time.now)

    @overdue_tickets = Ticket.where(
      "(resolution_date IS NULL AND creation_date + (EXTRACT(DAY FROM limit_time_resolution) * interval '1 day') < NOW() - interval '1 day') OR " \
      "(resolution_date IS NOT NULL AND (resolution_date > creation_date + (EXTRACT(DAY FROM limit_time_resolution) * interval '1 day') OR resolution_date IS NULL))"
    )

  end


  def search
    @query = params[:query]
    @ticket_title =Ticket.joins(ticket_list: :user).where("tickets.title ILIKE :query OR tickets.incident_description ILIKE :query OR users.email ILIKE :query", query: "%#{@query}%")
  end


  def dates_search
    start_date = parse_date_param(params[:start_date])
    end_date = parse_date_param(params[:end_date])

    if start_date.nil? || end_date.nil?
      flash[:alert] = "Please select valid start and end dates."
      redirect_to user_ticket_report_path(current_user)
    else
      # Perform the ticket search based on the start and end dates
      @tickets = Ticket.where(creation_date: start_date.beginning_of_day..end_date.end_of_day)

      @tickets_open= Ticket.where(creation_date: start_date.beginning_of_day..end_date.end_of_day, state: "Open")
      @tickets_closed = Ticket.where(resolution_date: start_date.beginning_of_day..end_date.end_of_day, state: "Closed")
      @tickets_reopen= Ticket.where(resolution_date: start_date.beginning_of_day..end_date.end_of_day, state: "ReOpen")

      @tag_counts = Tag.joins(:tag_list).where(tag_lists: { ticket_id: @tickets.pluck(:id) }).group(:name).count
      
      @start_end="#{start_date} - #{end_date}"

      respond_to do |format|
        format.html
        format.js
      end
    end
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

    def parse_date_param(date_string)
      Date.parse(date_string) if date_string.present?
    rescue ArgumentError
      nil
    end
end
