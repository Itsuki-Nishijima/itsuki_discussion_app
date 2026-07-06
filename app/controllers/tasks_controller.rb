class TasksController < ApplicationController

  def new
    @board = Board.find(params[:board_id])
    @task = Task.new
  end

  def create
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build(task_params)
    @task.user = current_user

    if @task.save
      redirect_to board_path(@board)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline)
  end
end