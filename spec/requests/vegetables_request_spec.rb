require 'rails_helper'

RSpec.describe 'Vegetables', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/vegetables/index'
      expect(response).to have_http_status(:success)
    end
  end
end
