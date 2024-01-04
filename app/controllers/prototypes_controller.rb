class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy] 
  before_action :authenticate_user!, except: [:index, :show]

  def index 
    @prototypes = Prototype.includes(:user)
  end

  def show
    # if params[:comment].present?
    #   # コメントが送信された場合の処理
    #   @comment = Comment.new(comment_params)
    #   @comments = @prototype.comments
    #   if @comment.save
    #     redirect_to prototype_path(@prototype)
    #   else
    #     render :show
    #   end
    # else
      # コメントが送信されなかった場合の処理
      @comment = Comment.new
      @comments = @prototype.comments
    end 
  
  
  # def show
  #   @comment = Comment.new
  #   @comments = @prototype.comments
  # end


 def new
  @prototype = Prototype.new
 end

 def edit
  @prototype = Prototype.find(params[:id])
 end

 def update
  @prototype = Prototype.find(params[:id])
  if @prototype.update(prototype_params)
    redirect_to prototype_path(@prototype)
  else
    render :edit
  end
 end

 def destroy
   @prototype = Prototype.find(params[:id])
  if @prototype.destroy
    redirect_to root_path
  else
    redirect_to root_path
  end
 end

def create
  @prototype = Prototype.new(prototype_params)
  if @prototype.save
    redirect_to prototype_path(@prototype)
  else
    @prototype = @comment.prototype
    # @comment = Comment.new(comment_params)
    @comments = @prototype.comments
    render "prototypes/show"
#   if @prototype.save
#     redirect_to root_path
#   else
#     render :new
  end
end 

private

def prototype_params
  params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id) 
 end

#  def comment_params
#   params.require(:comment).permit(:comments).merge(user_id: prototype_id) 
#  end

 def set_prototype
  @prototype = Prototype.find(params[:id])
end

 def contributor_confirmation
  redirect_to root_path unless current_user == @prototype.user
end
 
end
