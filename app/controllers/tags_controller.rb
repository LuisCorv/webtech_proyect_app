class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /tags or /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1 or /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
    @current_taglist_id = session[:current_taglist_id]
  end

  # GET /tags/1/edit
  def edit
    @current_taglist_id = session[:current_taglist_id]
  end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)

  
      if @tag.save
        tg=TagList.find(params[:tag][:tag_list_id])
        
        if current_user.Executive? 
          assign_or_list=(params[:tag][:assign_list_nothing]).split(" ")
          if assign_or_list[0]=="assign"
            redirect_to user_assign_ticket_ticket_tag_list_tag_path(current_user,tg.ticket.assign_ticket,tg.ticket,tg,@tag), notice: "Tag was successfully created." 
          end  
        elsif current_user.Supervisor? or current_user.Administrator?
          redirect_to user_ticket_tag_list_tag_path(current_user,tg.ticket,tg,@tag), notice: "Tag was successfully created."

        end
      else
        render :new, status: :unprocessable_entity 
      end
    
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    
      if @tag.update(tag_params)
        tg=TagList.find(params[:tag][:tag_list_id])
        
        if current_user.Executive? 
          assign_or_list=(params[:tag][:assign_list_nothing]).split(" ")
          if assign_or_list[0]=="assign"
            redirect_to user_assign_ticket_ticket_tag_list_tag_path(current_user,tg.ticket.assign_ticket,tg.ticket,tg,@tag), notice: "Tag was successfully updated." 
          end  
        elsif current_user.Supervisor? or current_user.Administrator?
          redirect_to user_ticket_tag_list_tag_path(current_user,tg.ticket,tg,@tag), notice: "Tag was successfully updated."

        end 
      else
        render :edit, status: :unprocessable_entity 
      end
   
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @tag.destroy

    tg=TagList.find(params[:tag_list_id])
        if current_user.Executive? 
          if params[:ticket_list_id].present?
            redirect_to user_ticket_list_ticket_tag_list_tags_path(current_user,tg.ticket.ticket_list,tg.ticket,tg), notice: "Tag was successfully destroyed." 
          elsif params[:assign_ticket_id].present?
            redirect_to user_assign_ticket_ticket_tag_list_tags_path(current_user,tg.ticket.assign_ticket,tg.ticket,tg), notice: "Tag was successfully destroyed." 
          end  
        elsif current_user.Supervisor? or current_user.Administrator?
          redirect_to user_ticket_tag_list_tags_path(current_user,tg.ticket,tg), notice: "Tag was successfully destroyed."

        end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:name, :tag_list_id)
    end
end
