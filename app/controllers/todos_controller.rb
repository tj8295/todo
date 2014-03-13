class TodosController < AuthenticatedController
  before_filter :ensure_sign_in

  def index
    # @todos = Todo.all
    # @todos = current_user.todos
    @todos = current_user.todos.map(&:decorator)
    @todo = Todo.new
  end

  def new
    @todos = Todo.all
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    # credit = Credit.new(current_user)
    if @todo.save_with_tags
      # if UserLevelPolicy.new(current_user).premium?
        # credit = credit - 1
      # else
        # credit = credit - 2
      # end

      # credit.save

      # if credit.depleted?
          #send insufficient credit email
        # elsif credit.low_laance
          # send low balance email
        # end

      AppMailer.delay.notify_on_new_todo(current_user, @todo)

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
