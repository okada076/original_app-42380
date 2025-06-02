require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '新規登録できるとき' do
    it '全ての項目が正しく入力されていれば登録できる' do
      expect(@user).to be_valid
    end
  end

  context '新規登録できないとき' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字未満では登録できない' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordとpassword_confirmationが一致していないと登録できない' do
      @user.password_confirmation = 'different'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
