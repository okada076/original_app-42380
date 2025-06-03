require 'rails_helper'
  RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '投稿の保存' do
    context '内容に問題がない場合' do
      it 'すべての項目が入力されていれば保存できる' do
        expect(@post).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'タイトルが空では保存できない' do
        @post.title = ''
        expect(@post).to_not be_valid
        expect(@post.errors.full_messages).to include("Title can't be blank")
      end

      it '内容が空では保存できない' do
        @post.content = ''
        expect(@post).to_not be_valid
        expect(@post.errors.full_messages).to include("Content can't be blank")
      end

      it 'カテゴリーが空では保存できない' do
        @post.category = nil
        expect(@post).to_not be_valid
        expect(@post.errors.full_messages).to include("Category can't be blank")
      end

      it '画像が添付されていないと保存できない' do
        @post.image = nil
        expect(@post).to_not be_valid
        expect(@post.errors.full_messages).to include("Image can't be blank")
      end

      it '野菜が紐づいていないと保存できない' do
        @post.vegetable = nil
        expect(@post).to_not be_valid
        expect(@post.errors.full_messages).to include("Vegetable must exist")
      end

      it 'ユーザーが紐づいていないと保存できない' do
        @post.user = nil
        expect(@post).to_not be_valid
        expect(@post.errors.full_messages).to include("User must exist")
      end
    end
  end
end
end
