require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }

  let(:headers) do
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(
        ENV['BASIC_AUTH_USER'], ENV['BASIC_AUTH_PASSWORD']
      ),
      'ACCEPT' => 'text/html'
    }
  end

  describe 'GET /posts/:id/edit' do
    context 'ログインしていないとき' do
      it 'ログインページへリダイレクトされる' do
        get edit_post_path(post), headers: headers
        expect(response).to redirect_to new_user_session_path
      end
    end

    context '投稿者以外のユーザーのとき' do
      before { sign_in other_user }

      it '投稿一覧にリダイレクトされる' do
        get edit_post_path(post), headers: headers
        expect(response).to redirect_to grow_logs_path
        expect(flash[:alert]).to eq '不正なアクセスです。'
      end
    end

    context '投稿者本人のとき' do
      before { sign_in user }

      it '編集ページにアクセスできる' do
        get edit_post_path(post), headers: {
          'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(
            ENV['BASIC_AUTH_USER'], ENV['BASIC_AUTH_PASSWORD']
          )
        }
        expect(response).to have_http_status(:success)
      end
    end
  end
  # ========================
  # ★ 追記：削除に関するテスト
  # ========================
  describe 'DELETE /posts/:id' do
    context 'ログインしていないとき' do
      it 'ログインページにリダイレクトされる' do
        delete post_path(post), headers: headers
        expect(response).to redirect_to new_user_session_path
      end
    end

    context '投稿者以外のユーザーのとき' do
      before do
        post # ★ 投稿を作っておく
        sign_in other_user
      end

      it 'トップページにリダイレクトされ、削除されない' do
        expect do
          delete post_path(post), headers: headers
        end.not_to change(Post, :count)
        expect(response).to redirect_to grow_logs_path
      end
    end

    context '投稿者本人のとき' do
      before do
        post # 投稿を作成しておく
        sign_in user
      end

      it '投稿を削除できてリダイレクトされる' do
        expect do
          delete post_path(post), headers: headers
        end.to change(Post, :count).by(-1)
        expect(response).to redirect_to grow_logs_path
      end
    end
  end
end
