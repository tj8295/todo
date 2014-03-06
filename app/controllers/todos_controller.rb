class TodosController < ApplicationController
  before_filter :ensure_sign_in

  def index
    @todos = Todo.all
    @todo = Todo.new
  end

  def new
    @todos = Todo.all
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save_with_tags
      AppMailer.notify_on_new_todo(current_user, @todo).deliver

      flash[:success] = "saved todo"
      redirect_to root_path
    else
      flash[:error] = "not saved"
      render :new
    end
  end

  def show
    @todo = Todo.find_by(token: params[:id])
  end

  private
  def todo_params
    params.require(:todo).permit(:name, :description)
  end
end
