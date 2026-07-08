class CommentsController < ApplicationController

  def create
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:task_id])
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to board_task_path(@board, @task)
    else
      render "tasks/show", status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end