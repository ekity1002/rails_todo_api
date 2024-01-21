require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # 事前にテスト用のTODOを作成
  let!(:todos) { create_list(:todo, 10) }
  let(:valid_attributes) {{todo: {title: "HOGE", due_date: Date.tomorrow}}}

  describe 'POST /todos' do
    context 'when the request is valid' do
      before {post '/todos', params: valid_attributes }
      it 'creates a new todos' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/todos', params: {todo: {due_date: Date.tomorrow }}}
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /todos' do
    before {get '/todos'}
    it 'returns todos' do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'GET /todos/:id' do
    before {get "/todos/#{todo_id}" }
    context 'when the record exists' do
      let(:todo_id) { todos.first.id }
      it 'returns todo' do
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)["id"]).to eq(todo_id)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT /todos/:id' do
    before { put "/todos/#{todo_id}", params: valid_attributes }
    context 'when the record exists' do
      let(:todo_id) { 1 }
      it 'updates the record' do
        expect(response).to have_http_status(200)
        updated_todo = Todo.find(todo_id)
        expect(updated_todo.title).to eq('HOGE')
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end