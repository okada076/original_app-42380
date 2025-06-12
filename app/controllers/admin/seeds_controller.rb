class Admin::SeedsController < ApplicationController
  
    skip_before_action :verify_authenticity_token

    def run
      load Rails.root.join('db/seeds.rb')
      render plain: "✅ seeds.rb 実行完了"
    end
  end
