require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:vegetable) { FactoryBot.create(:vegetable) }
  let(:tag_tomato) { FactoryBot.create(:tag, name: 'トマト') }
  let(:tag_carrot) { FactoryBot.create(:tag, name: 'にんじん') }

  let(:grow_post) do
    post = FactoryBot.create(:post, category: :grow_log, vegetable: vegetable, user: user)
    post.tags << tag_tomato
    post
  end

  let(:trouble_post) do
    post = FactoryBot.create(:post, category: :trouble_note, vegetable: vegetable, user: user)
    post.tags << tag_carrot
    post
  end

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
        get edit_post_path(grow_post), headers: headers
        expect(response).to redirect_to new_user_session_path
      end
    end

    context '投稿者以外のユーザーのとき' do
      before { sign_in other_user }

      it '投稿一覧にリダイレクトされる' do
        get edit_post_path(grow_post), headers: headers
        expect(response).to redirect_to grow_logs_path
        expect(flash[:alert]).to eq '不正なアクセスです。'
      end
    end

    context '投稿者本人のとき' do
      before { sign_in user }

      it '編集ページにアクセスできる' do
        get edit_post_path(grow_post), headers: headers
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'DELETE /posts/:id' do
    context 'ログインしていないとき' do
      it 'ログインページにリダイレクトされる' do
        delete post_path(grow_post), headers: headers
        expect(response).to redirect_to new_user_session_path
      end
    end

    context '投稿者以外のユーザーのとき' do
      before do
        grow_post
        sign_in other_user
      end

      it 'トップページにリダイレクトされ、削除されない' do
        expect do
          delete post_path(grow_post), headers: headers
        end.not_to change(Post, :count)
        expect(response).to redirect_to grow_logs_path
      end
    end

    context '投稿者本人のとき' do
      before do
        grow_post
        sign_in user
      end

      it '投稿を削除できてリダイレクトされる' do
        expect do
          delete post_path(grow_post), headers: headers
        end.to change(Post, :count).by(-1)
        expect(response).to redirect_to grow_logs_path
      end
    end
  end

  describe 'GET /tags/:id (タグ検索)' do
    before(:all) do
      @tag_tomato = create(:tag, name: 'トマト')
      @tag_carrot = create(:tag, name: 'にんじん')
      @tag_piman  = create(:tag, name: 'ピーマン')

      @grow_post = create(:post, title: '発芽しましたA', category: 'grow_log')
      @grow_post.tags << @tag_tomato

      @trouble_post = create(:post, title: '枯れましたB', category: 'trouble_note')
      @trouble_post.tags << @tag_carrot
    end

    it 'タグで絞り込める（トマト）' do
      get tag_path(@tag_tomato)
      expect(response.body).to include(@grow_post.title)
      expect(response.body).not_to include(@trouble_post.title)
    end

    it 'カテゴリ＋タグで絞り込める（トマト＋育成記録）' do
      get tag_path(@tag_tomato), params: { filter: 'grow_log' }
      expect(response.body).to include(@grow_post.title)
      expect(response.body).not_to include(@trouble_post.title)
    end

    it 'カテゴリ＋タグで絞り込める（にんじん＋つまずき）' do
      get tag_path(@tag_carrot), params: { filter: 'trouble_note' }
      expect(response.body).to include(@trouble_post.title)
      expect(response.body).not_to include(@grow_post.title)
    end

    it 'タグが存在しない場合は投稿が表示されない' do
      get tag_path(@tag_piman)
      expect(response.body).not_to include(@grow_post.title)
      expect(response.body).not_to include(@trouble_post.title)
    end
  end
end
