require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = build(:like)
  end

  describe 'バリデーションのテスト' do
    context '有効な場合' do
      it 'userとpostがあれば有効' do
        expect(@like).to be_valid
      end
    end

    context '無効な場合' do
      it 'userがなければ無効' do
        @like.user = nil
        expect(@like).to_not be_valid
      end

      it 'postがなければ無効' do
        @like.post = nil
        expect(@like).to_not be_valid
      end

      it '同じuserが同じpostに2回いいねすると無効' do
        like1 = create(:like) # 1つ目をDBに保存
        like2 = build(:like, user: like1.user, post: like1.post) # 同じuserとpostで作成
        like2.valid?
        expect(like2.errors.full_messages).to include('User has already been taken')
      end
    end
  end
end
