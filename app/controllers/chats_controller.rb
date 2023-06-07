class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /chats or /chats.json
  def index
    @chats = Chat.all
  end

  # GET /chats/1 or /chats/1.json
  def show
    session[:current_chat_id] = @chat.id
  end

  # GET /chats/new
  def new
    @current_ticket= Ticket.find(params[:ticket_id])
    if current_user.Executive? 
      if params[:ticket_list_id].present?
        redirect_to user_ticket_list_ticket_chats_path(current_user,@current_ticket.ticket_list,@current_ticket) 
      elsif params[:assign_ticket_id].present?
        redirect_to user_assign_ticket_ticket_chats_path(current_user,@current_ticket.assign_ticket,@current_ticket) 
      end  
    elsif current_user.Supervisor? or current_user.Administrator?
      redirect_to user_ticket_chats_path(current_user,@current_ticket)

    end 
  end

  # GET /chats/1/edit
  def edit
    @current_ticket= Ticket.find(params[:ticket_id])
    if current_user.Executive? 
      if params[:ticket_list_id].present?
        redirect_to user_ticket_list_ticket_chat_path(current_user,@current_ticket.ticket_list,@current_ticket,@chat) 
      elsif params[:assign_ticket_id].present?
        redirect_to user_assign_ticket_ticket_chat_path(current_user,@current_ticket.assign_ticket,@current_ticket,@chat) 
      end  
    elsif current_user.Supervisor? or current_user.Administrator?
      redirect_to user_ticket_chat_path(current_user,@current_ticket,@chat)

    end 
  end

  # POST /chats or /chats.json
  def create
    @chat = Chat.new(chat_params)

    respond_to do |format|
      if @chat.save
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully created." }
        format.json { render :show, status: :created, location: @chat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    if current_user.Supervisor? or current_user.Administrator?
      @chat.comments.destroy_all

      @current_ticket= Ticket.find(params[:ticket_id])
      if current_user.Executive? 
        if params[:ticket_list_id].present?
          redirect_to user_ticket_list_ticket_chat_path(current_user,@current_ticket.ticket_list,@current_ticket,@chat) , notice: "Chat was successfully clean."
        elsif params[:assign_ticket_id].present?
          redirect_to user_assign_ticket_ticket_chat_path(current_user,@current_ticket.assign_ticket,@current_ticket,@chat), notice: "Chat was successfully clean." 
        end  
      elsif current_user.Supervisor? or current_user.Administrator?
        redirect_to user_ticket_chat_path(current_user,@current_ticket,@chat), notice: "Chat was successfully clean."

      end 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:ticket_id)
    end
end
