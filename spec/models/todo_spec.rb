require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) do
    Todo.new(
      title: "Test Todo",
      description: "Test description",
      due_date: Date.tomorrow,
      completed: true
    )
  end

  it "is valid with a title, description, completed, due_date" do
    expect(todo).to be_valid
  end

  context "when title is missing" do
    it "is invalid" do
      todo.title = nil
      expect(todo).not_to be_valid
    end
  end

  context "when description is over 500 chars" do
    it "is invalid" do
      todo.description = "a"*501
      expect(todo).not_to be_valid
    end
  end

  context "due date is not future" do
    it "is invalid" do
      todo.due_date = Date.yesterday
      expect(todo).not_to be_valid
    end
  end
end
