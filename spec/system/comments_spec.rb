require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  let(:user) { create(:user, password: 'password123') }
  let(:post_record) { create(:post) }

  before do
    driven_by(:rack_test) # JSを使わない通常のテストドライバ
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password123'
    click_button 'Log in'
  end

  it 'コメントを投稿できる' do
    visit post_path(post_record)

    fill_in 'コメント内容', with: 'これはテストコメントです'
    click_button '投稿する'

    expect(page).to have_content('これはテストコメントです')
    expect(page).to have_content(user.nickname)
  end

  it '空コメントは投稿できずエラーメッセージが出る' do
    visit post_path(post_record)

    fill_in 'コメント内容', with: ''
    click_button '投稿する'

    expect(page).to have_content('コメントの投稿に失敗しました')
  end
end
