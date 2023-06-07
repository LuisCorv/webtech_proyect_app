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
  end

  # GET /ticket_lists/new
  def new
    redirect_to user_ticket_lists_path, alert: "You can't create Ticket List this way, you should make a 'new Ticket' for that"

  end

  # GET /ticket_lists/1/edit
  def edit
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
    @ticket_list.destroy

    respond_to do |format|
      format.html { redirect_to ticket_lists_url, notice: "Ticket list was successfully destroyed." }
      format.json { head :no_content }
    end
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
