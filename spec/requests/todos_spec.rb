require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  describe 'POST /todos' do
    let(:valid_attributes) {{todo: {title: "HOGE", due_date: Date.tomorrow}}}
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
end