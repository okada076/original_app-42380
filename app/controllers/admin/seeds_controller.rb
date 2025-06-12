class Admin::SeedsController < ApplicationController
  lass SeedsController < ApplicationController
    # 誰でも実行できてしまうので、必要なら簡単な認証をつけても良い
    skip_before_action :verify_authenticity_token

    def run
      load Rails.root.join('db/seeds.rb')
      render plain: "✅ seeds.rb 実行完了"
    end
  end
