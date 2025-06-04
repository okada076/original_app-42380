# require 'rails_helper'

# #RSpec.describe 'Comments', type: :request do
#   let(:user) { create(:user) }
#   let(:post_record) { create(:post, user: user) }

#   before do
#     post user_session_path, params: {
#       user: {
#         email: user.email,
#         password: 'password123' # ← FactoryBotで設定しているパスワードに合わせる
#       }
#     }
#   #end

#   #describe 'POST /posts/:post_id/comments' do
#     #context 'コメントが有効な場合' do
#       it 'コメントが保存される' do
#         expect do
#           post post_comments_path(post_record), params: { comment: { content: 'テストコメント' } }
#         end.to change(Comment, :count).by(1)

#         expect(response).to redirect_to(post_path(post_record))
#       end
#     end

#     context 'コメントが無効な場合' do
#       it 'コメントが保存されず、詳細ページが再表示される' do
#         expect do
#           post post_comments_path(post_record), params: { comment: { content: '' } }
#         end.not_to change(Comment, :count)

#         expect(response).to have_http_status(422)
#         expect(response.body).to include('コメントの投稿に失敗しました')
#       end
#     end
#   end
# #end
