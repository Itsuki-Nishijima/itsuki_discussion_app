class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]


  def new
    @board = Board.find(params[:board_id])
    @task = Task.new
  end

  def create
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build(task_params)
    @task.user = current_user

    if @task.save
      redirect_to board_path(@board), notice: 'タスクを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])

    @comment = Comment.new
    @comments = @task.comments
  end

  def edit
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end

  def update
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@board, @task), notice: 'タスクを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
    @task.destroy
    redirect_to board_path(@board), notice: 'タスクを削除しました'
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :eyecatch)
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_task
    @task = @board.tasks.find(params[:id])
  end

  def authorize_user!
    redirect_to board_path(@board),
                alert: "権限がありません" unless @task.user == current_user
  end
end
