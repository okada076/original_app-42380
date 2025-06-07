require 'rails_helper'

RSpec.describe 'StepProgresses', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @vegetable = FactoryBot.create(:vegetable, name: 'トマト')
    @step1 = FactoryBot.create(:growing_step, vegetable: @vegetable, step_number: 1, title: '種まき', content: '種をまく')

    3.times do |i|
      FactoryBot.create(:growing_step, vegetable: @vegetable, step_number: i + 1, title: "STEP#{i + 1}", content: "内容#{i + 1}")
    end

    sign_in @user
  end

  it 'STEPをチェックすると、保存されてリロード後もチェックが維持されている' do
    visit vegetable_growing_steps_path(@vegetable)

    expect(page).to have_unchecked_field('STEP 1: 種まき')
    check 'STEP 1: 種まき'

    visit current_path
    expect(page).to have_checked_field('STEP 1: 種まき')
  end

  it 'チェックを入れると記録が保存される（別のSTEP表示名）' do
    visit vegetable_growing_steps_path(@vegetable)

    expect(page).to have_unchecked_field('STEP 1')
    check 'STEP 1'

    visit current_path
    expect(page).to have_checked_field('STEP 1')
  end

  it 'ログインユーザーが手順ページへ遷移できる' do
    visit root_path
    click_link '作り方ガイド'

    expect(current_path).to eq(vegetables_path)
    click_link 'トマト'

    expect(current_path).to eq(vegetable_growing_steps_path(@vegetable))
    expect(page).to have_content('トマト の作り方ガイド')
  end
end
