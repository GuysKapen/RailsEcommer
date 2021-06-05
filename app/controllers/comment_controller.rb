class CommentController < ApplicationController
  def new

  end

  def create

  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
