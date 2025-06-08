require 'rails_helper'

def sign_in_as(user)
  Capybara.reset_sessions!
  visit destroy_user_session_path if defined?(destroy_user_session_path) # Deviseログアウト
  visit new_user_session_path
  expect(page).to have_field('Email') # 念のため確認
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

RSpec.describe 'StepProgresses', type: :system do
  include Warden::Test::Helpers

  let!(:user) { create(:user) }
  let!(:vegetable) { create(:vegetable, name: "トマト#{SecureRandom.hex(4)}") }
  let!(:step1) { create(:growing_step, vegetable: vegetable, step_number: 1, title: '種まき', content: '種をまく') }

  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'STEPをチェックすると、保存されてリロード後もチェックが維持されている' do
    sign_in_as(user)
    visit vegetable_growing_steps_path(vegetable)
    checkbox_id = "step_checkbox_#{step1.id}"
    expect(page).to have_unchecked_field(checkbox_id)
    check(checkbox_id)
    visit current_path
    expect(page).to have_checked_field(checkbox_id)
  end

  it 'チェックを入れると記録が保存される（別のSTEP表示名）' do
    Capybara.reset_sessions!
    sign_in_as(user)

    step = create(:growing_step, vegetable: vegetable, step_number: 2, title: '間引き', content: '小さい芽を抜く')
    visit vegetable_growing_steps_path(vegetable)

    checkbox_id = "step_checkbox_#{step.id}"

    # 要素が描画されるまで待機
    expect(page).to have_selector("##{checkbox_id}")
    expect(page).to have_unchecked_field(id: checkbox_id)

    check(checkbox_id)
    sleep 0.5 # 非同期保存の待機

    visit current_path
    expect(page).to have_checked_field(id: checkbox_id)
  end

  it 'ログインユーザーが手順ページへ遷移できる' do
    sign_in_as(user)
    visit root_path
    click_link '作り方ガイド'
    expect(current_path).to eq(vegetables_path)

    click_link vegetable.name
    expect(current_path).to eq(vegetable_growing_steps_path(vegetable))
    expect(page).to have_content("#{vegetable.name} の作り方ガイド")
  end

  it '未ログインユーザーは育て方手順ページにアクセスできずログインページにリダイレクトされる' do
    Capybara.reset_sessions!
    vegetable = create(:vegetable)
    create(:growing_step, vegetable: vegetable, step_number: 1)
    visit vegetable_growing_steps_path(vegetable)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('ログイン')
  end
end
