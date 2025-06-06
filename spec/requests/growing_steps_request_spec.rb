require 'rails_helper'

RSpec.describe "GrowingSteps", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/growing_steps/index"
      expect(response).to have_http_status(:success)
    end
  end

end
