class TagListsController < ApplicationController
  before_action :set_tag_list, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /tag_lists or /tag_lists.json
  def index
    @tag_lists = TagList.all
  end

  # GET /tag_lists/1 or /tag_lists/1.json
  def show
    session[:current_taglist_id] = @tag_list.id
  end

  # GET /tag_lists/new
  def new
    @current_ticket= Ticket.find(params[:ticket_id])
    if current_user.Executive? 
      if params[:ticket_list_id].present?
        redirect_to user_ticket_list_ticket_tag_lists_path(current_user,@current_ticket.ticket_list,@current_ticket) 
      elsif params[:assign_ticket_id].present?
        redirect_to user_assign_ticket_ticket_tag_lists_path(current_user,@current_ticket.assign_ticket,@current_ticket) 
      end  
    elsif current_user.Supervisor? or current_user.Administrator?
      redirect_to user_ticket_tag_lists_path(current_user,@current_ticket)

    end 
  end

  # GET /tag_lists/1/edit
  def edit
    @current_ticket= Ticket.find(params[:ticket_id])
    if current_user.Executive? 
      if params[:ticket_list_id].present?
        redirect_to user_ticket_list_ticket_tag_list_path(current_user,@current_ticket.ticket_list,@current_ticket,@tag_list) 
      elsif params[:assign_ticket_id].present?
        redirect_to user_assign_ticket_ticket_tag_list_path(current_user,@current_ticket.assign_ticket,@current_ticket,@tag_list) 
      end  
    elsif current_user.Supervisor? or current_user.Administrator?
      redirect_to user_ticket_tag_list_path(current_user,@current_ticket,@tag_list)

    end 
  end

  # POST /tag_lists or /tag_lists.json
  def create
    @tag_list = TagList.new(tag_list_params)

    respond_to do |format|
      if @tag_list.save
        format.html { redirect_to tag_list_url(@tag_list), notice: "Tag list was successfully created." }
        format.json { render :show, status: :created, location: @tag_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_lists/1 or /tag_lists/1.json
  def update
    respond_to do |format|
      if @tag_list.update(tag_list_params)
        format.html { redirect_to tag_list_url(@tag_list), notice: "Tag list was successfully updated." }
        format.json { render :show, status: :ok, location: @tag_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_lists/1 or /tag_lists/1.json
  def destroy

    @tag_list.tags.destroy_all

    @current_ticket= Ticket.find(params[:ticket_id])
    if current_user.Executive? 
      if params[:ticket_list_id].present?
        redirect_to user_ticket_list_ticket_tag_list_path(current_user,@current_ticket.ticket_list,@current_ticket,@tag_list) , notice: "Tag list was successfully clean."
      elsif params[:assign_ticket_id].present?
        redirect_to user_assign_ticket_ticket_tag_list_path(current_user,@current_ticket.assign_ticket,@current_ticket,@tag_list), notice: "Tag list was successfully clean." 
      end  
    elsif current_user.Supervisor? or current_user.Administrator?
      redirect_to user_ticket_tag_list_path(current_user,@current_ticket,@tag_list), notice: "Tag list was successfully clean."

    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_list
      @tag_list = TagList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_list_params
      params.require(:tag_list).permit(:ticket_id)
    end
end
