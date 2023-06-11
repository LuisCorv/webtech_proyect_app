class AssignTicketsController < ApplicationController
  before_action :set_assign_ticket, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /assign_tickets or /assign_tickets.json
  def index
    @assign_tickets = AssignTicket.all
    session[:assign] = "yes"
  end

  # GET /assign_tickets/1 or /assign_tickets/1.json
  def show
  end

  # GET /assign_tickets/new
  def new
    
    if current_user.User? 
      redirect_to user_tickets_path(current_user), alert: "You can't assign tickets, because you are a User, and not support staff"
      return
    elsif current_user.Executive?
      redirect_to user_assign_tickets_path(current_user), alert: "You can't created assign tickets, only Supervisor and Administrators can"
      return
    end

    @assign_ticket = AssignTicket.new
  end

  # GET /assign_tickets/1/edit
  def edit

    if current_user.Executive? or current_user.User? 
      redirect_to user_tickets_path(current_user), alert: "You can't edit assign tickets, only Supervisor and Administrators can"
      return
    end
  end

  # POST /assign_tickets or /assign_tickets.json
  def create
    @assign_ticket = AssignTicket.new(assign_ticket_params)

    respond_to do |format|
      if @assign_ticket.save
        format.html { redirect_to assign_ticket_url(@assign_ticket), notice: "Assign ticket was successfully created." }
        format.json { render :show, status: :created, location: @assign_ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assign_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assign_tickets/1 or /assign_tickets/1.json
  def update
    respond_to do |format|
      if @assign_ticket.update(assign_ticket_params)
        format.html { redirect_to assign_ticket_url(@assign_ticket), notice: "Assign ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @assign_ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assign_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assign_tickets/1 or /assign_tickets/1.json
  def destroy
    @assign_ticket.destroy

    respond_to do |format|
      format.html { redirect_to assign_tickets_url, notice: "Assign ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assign_ticket
      @assign_ticket = AssignTicket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assign_ticket_params
      params.require(:assign_ticket).permit(:user_id, :ticket_id)
    end
end
