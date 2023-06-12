class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @current_chat_id = session[:current_chat_id]
  end

  # GET /comments/1/edit
  def edit
    @current_chat_id = session[:current_chat_id]
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    if current_user.Executive?
      @comment.writer="🐾 "+@comment.writer
    elsif current_user.Supervisor?
      @comment.writer="🌀 "+@comment.writer
    elsif current_user.Administrator?
      @comment.writer="⚙️ "+@comment.writer
    end

      if @comment.save
        cha=Chat.find(params[:comment][:chat_id])
       
        if current_user.Executive? 
           assign_or_list=(params[:comment][:assign_list_nothing]).split(" ")
         if assign_or_list[0]=="assign"
            redirect_to user_assign_ticket_ticket_chat_comment_path(current_user,cha.ticket.assign_ticket,cha.ticket,cha,@comment), notice: "Comment was successfully created." 
          end  
        elsif current_user.Supervisor? or current_user.Administrator?
          redirect_to user_ticket_chat_comment_path(current_user,cha.ticket,cha,@comment), notice: "Comment was successfully created."

        end 
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    if ((current_user.name+" "+current_user.last_name) == params[:comment][:writer]) or (current_user.Supervisor? or current_user.Administrator?)
      if @comment.update(comment_params)
        cha=Chat.find(params[:comment][:chat_id])
        if current_user.Executive? 
          assign_or_list=(params[:comment][:assign_list_nothing]).split(" ")
          if assign_or_list[0]=="assign"
            redirect_to user_assign_ticket_ticket_chat_comment_path(current_user,cha.ticket.assign_ticket,cha.ticket,cha,@comment), notice: "Comment was successfully updated." 
          end  
        elsif current_user.Supervisor? or current_user.Administrator?
          redirect_to user_ticket_chat_comment_path(current_user,cha.ticket,cha,@comment), notice: "Comment was successfully updated."

        end 
      else
       render :edit, status: :unprocessable_entity 
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

        cha=Chat.find(params[:chat_id])
        if current_user.Executive? 
          if params[:ticket_list_id].present?
            redirect_to user_ticket_list_ticket_chat_comments_path(current_user,cha.ticket.ticket_list,cha.ticket,cha), notice: "Comment was successfully destroyed." 
          elsif params[:assign_ticket_id].present?
            redirect_to user_assign_ticket_ticket_chat_comments_path(current_user,cha.ticket.assign_ticket,cha.ticket,cha), notice: "Comment was successfully destroyed." 
          end  
        elsif current_user.Supervisor? or current_user.Administrator?
          redirect_to user_ticket_chat_comments_path(current_user,cha.ticket,cha), notice: "Comment was successfully destroyed."

        end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:text, :writer, :chat_id)
    end
end
