class UserCommentsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @user_comment = @user.user_comments.build(user_comment_params)
    respond_to do |format|
      if @user_comment.save
        format.js { render :index }
      else
        format.html { redirect_to user_path(@user), notice: '投稿できませんでした...' }
      end
    end
  end

  def show
  end

  private
  def user_comment_params
    params.require(:user_comment).permit(:user_id, :content, :comment_user_id)
  end
end
