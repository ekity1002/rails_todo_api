class TodosController < ApplicationController
  def create
    todo = Todo.new(todo_params)
    puts todo
    if todo.save
      render json: todo, status: :created
    else
      render json: { error: todo.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def todo_params
    params.require(:todo).permit(:title, :due_date)
  end
end