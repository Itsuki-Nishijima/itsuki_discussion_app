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

  def show
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end

  def edit
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end

  def update
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@board, @task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
    @task.destroy
    redirect_to board_path(@board), notice: "Taskを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline)
  end
end