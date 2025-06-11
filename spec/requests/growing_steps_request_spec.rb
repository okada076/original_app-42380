require 'rails_helper'

RSpec.describe "GrowingSteps", type: :request do
  include Devise::Test::IntegrationHelpers  

  let(:user) { FactoryBot.create(:user) }

  describe "GET /index" do
    before do
      sign_in user
    end

    it "returns http success" do
      get "/growing_steps/index"
      expect(response).to have_http_status(:success)
    end
  end
end
