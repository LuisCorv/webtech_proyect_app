class TicketListsController < ApplicationController
  before_action :set_ticket_list, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /ticket_lists or /ticket_lists.json
  def index
    @ticket_lists = TicketList.all
    session[:assign] = "no"
  end

  # GET /ticket_lists/1 or /ticket_lists/1.json
  def show
    redirect_to user_ticket_list_ticket_path(current_user,@ticket_list, @ticket_list.ticket),alert:"You can't access that method"
  end

  # GET /ticket_lists/new
  def new
    redirect_to user_ticket_lists_path(current_user), alert: "You can't create Ticket List this way, you should make a 'new Ticket' for that"

  end

  # GET /ticket_lists/1/edit
  def edit
    redirect_to user_ticket_lists_path(current_user), alert: "You can't edit a Ticket List element"
  end

  # POST /ticket_lists or /ticket_lists.json
  def create
    @ticket_list = TicketList.new(ticket_list_params)

    respond_to do |format|
      if @ticket_list.save
        format.html { redirect_to ticket_list_url(@ticket_list), notice: "Ticket list was successfully created." }
        format.json { render :show, status: :created, location: @ticket_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_lists/1 or /ticket_lists/1.json
  def update
    respond_to do |format|
      if @ticket_list.update(ticket_list_params)
        format.html { redirect_to ticket_list_url(@ticket_list), notice: "Ticket list was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_lists/1 or /ticket_lists/1.json
  def destroy
    redirect_to user_ticket_lists_path(@ticket_list.user), alert: "You can't delete a Ticket List element"

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_list
      @ticket_list = TicketList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_list_params
      params.require(:ticket_list).permit(:user_id, :ticket_id)
    end
end
