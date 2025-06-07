require 'rails_helper'

def sign_in_as(user)
  visit new_user_session_path
  fill_in 'メールアドレス', with: user.email
  fill_in 'パスワード', with: user.password
  click_button 'ログイン'
end

RSpec.describe 'StepProgresses', type: :system do
  include Warden::Test::Helpers

  before do
    driven_by(:selenium_chrome_headless)

    @user = FactoryBot.create(:user)
    @vegetable = FactoryBot.create(:vegetable, name: "トマト#{SecureRandom.hex(4)}")
    @step1 = FactoryBot.create(:growing_step, vegetable: @vegetable, step_number: 1, title: '種まき', content: '種をまく')

    3.times do |i|
      FactoryBot.create(:growing_step, vegetable: @vegetable, step_number: i + 1, title: "STEP#{i + 1}", content: "内容#{i + 1}")
    end
  end

  it 'STEPをチェックすると、保存されてリロード後もチェックが維持されている' do
    sign_in_as(@user)
    visit vegetable_growing_steps_path(@vegetable)

    checkbox_id = "step_checkbox_#{@step1.id}"

    expect(page).to have_unchecked_field(checkbox_id)
    check(checkbox_id)

    visit current_path
    expect(page).to have_checked_field(checkbox_id)
  end

  it 'チェックを入れると記録が保存される（別のSTEP表示名）' do
    sign_in_as(@user)
    visit vegetable_growing_steps_path(@vegetable)

    checkbox_id = "step_checkbox_#{@step1.id}"

    expect(page).to have_unchecked_field(id: checkbox_id)
    check(checkbox_id)

    visit current_path
    expect(page).to have_checked_field(id: checkbox_id)
  end

  it 'ログインユーザーが手順ページへ遷移できる' do
    sign_in_as(@user)

    visit root_path
    click_link '作り方ガイド'

    expect(current_path).to eq(vegetables_path)

    # 修正ポイント（リンクが見つからない問題に対応）
    find("a[href='#{vegetable_growing_steps_path(@vegetable)}']").click

    expect(current_path).to eq(vegetable_growing_steps_path(@vegetable))
    expect(page).to have_content("#{@vegetable.name} の作り方ガイド")
  end

  it '未ログインユーザーは育て方手順ページにアクセスできずログインページにリダイレクトされる' do
    Capybara.reset_sessions! # ← Deviseのログアウト代替手段（system spec用）

    vegetable = FactoryBot.create(:vegetable)
    FactoryBot.create(:growing_step, vegetable: vegetable, step_number: 1)

    visit vegetable_growing_steps_path(vegetable)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('ログイン')
  end
end
