require 'rails_helper'

def sign_in_as(user)
  Capybara.reset_sessions!
  visit destroy_user_session_path if defined?(destroy_user_session_path) # Deviseログアウト
  visit new_user_session_path
  expect(page).to have_field('Email') # 念のため確認
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'ログイン'
end

RSpec.describe 'StepProgresses', type: :system do
  include Warden::Test::Helpers

  let!(:user) { create(:user) }
  let!(:vegetable) { create(:vegetable, name: "トマト#{SecureRandom.hex(4)}") }
  let!(:step1) { create(:growing_step, vegetable: vegetable, step_number: 1, title: '種まき', content: '種をまく') }

  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'STEPをチェックすると、保存されてリロード後もチェックが維持されている', js: true do
  sign_in_as(user)
  visit vegetable_growing_steps_path(vegetable)

  checkbox_id = "step_checkbox_#{step1.id}"

  # チェックボックスが表示されるまで待つ
  expect(page).to have_selector("##{checkbox_id}.saved")

  # チェック前に未チェック状態を確認
  expect(page).to have_unchecked_field(checkbox_id)

  check(checkbox_id)
  expect(page).to have_checked_field(checkbox_id)

  visit current_path
  expect(page).to have_checked_field(checkbox_id)
end

  it 'チェックを入れると記録が保存される（別のSTEP表示名）' do
    Capybara.reset_sessions!
    sign_in_as(user)

    # 明示的にstepをここで作成する（IDを固定化）
    step = create(:growing_step, vegetable: vegetable, step_number: 2, title: '間引き', content: '小さい芽を抜く')
    checkbox_id = "step_checkbox_#{step.id}"

    visit vegetable_growing_steps_path(vegetable)

    # チェックボックスが描画されるまで待つ
    expect(page).to have_selector("##{checkbox_id}")

    # チェックして保存処理
    check(checkbox_id)

    # 非同期保存が完了するまで待つ（sleepの代わりに保存完了の条件で待つのがベター）
    expect(page).to have_checked_field(checkbox_id)

    # ページをリロードしてもチェックが維持されているか確認
    visit current_path
    expect(page).to have_checked_field(checkbox_id)
  end

  it 'ログインユーザーが手順ページへ遷移できる' do
  sign_in_as(user)
  visit root_path

  expect(page).to have_link('作り方ガイド', href: vegetables_path)
  click_link '作り方ガイド'

  expect(current_path).to eq(vegetables_path)

  expect(page).to have_link(vegetable.name)
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
