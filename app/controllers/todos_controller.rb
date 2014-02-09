class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def new
    @todos = Todo.all
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      flash[:success] = "saved todo"
      redirect_to root_path
    else
      flash[:error] = "not saved"
      render :new
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  private
    def todo_params
      params.require(:todo).permit(:name, :description)
    end
end
