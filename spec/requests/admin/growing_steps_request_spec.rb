require 'rails_helper'

RSpec.describe 'Admin::GrowingSteps', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/growing_steps/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/admin/growing_steps/create'
      expect(response).to have_http_status(:success)
    end
  end
end
