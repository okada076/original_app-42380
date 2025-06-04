require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = build(:comment) # FactoryBot を使ってコメントを作成
  end

  describe 'コメントの保存' do
    context '内容に問題がない場合' do
      it 'contentがあれば保存できる' do
        expect(@comment).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'contentが空では保存できない' do
        @comment.content = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Content can't be blank")
      end

      it 'userが紐づいていないと保存できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end

      it 'postが紐づいていないと保存できない' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Post must exist')
      end
    end
  end
end
