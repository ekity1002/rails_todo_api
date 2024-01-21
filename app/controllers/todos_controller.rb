class TodosController < ApplicationController
  def index
    todos = Todo.all
    render json: todos
  end

  def show
    todo = Todo.find(params[:id])
    render json: todo
  end

  def create
    todo = Todo.new(todo_params)
    puts todo
    if todo.save
      render json: todo, status: :created
    else
      render json: { error: todo.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    todo = Todo.find(params[:id])
    if todo.update(todo_params)
      render json: todo, status: :ok
    else
      render json: { error: todo.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    if todo
      todo.destroy
      head :no_content
    else
      render json: { error: 'Todo not found'}, status: :not_found
    end
  end

  private
  def todo_params
    params.require(:todo).permit(:title, :description, :due_date, :completed)
  end
end