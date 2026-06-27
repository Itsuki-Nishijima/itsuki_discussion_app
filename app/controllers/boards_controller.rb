class BoardsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :description)
  end
end