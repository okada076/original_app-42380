require 'rails_helper'

RSpec.describe "GrowingSteps", type: :request do
  include Devise::Test::IntegrationHelpers  

  let(:user) { FactoryBot.create(:user) }

  describe "GET /index" do
    before do
      sign_in user
    end

    let(:vegetable) { FactoryBot.create(:vegetable) }

it "returns http success" do
  sign_in user
  get vegetable_growing_steps_path(vegetable)
  expect(response).to have_http_status(:success)
  end
 end
end
