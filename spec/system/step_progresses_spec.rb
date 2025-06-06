require 'rails_helper'

RSpec.describe 'StepProgresses', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @vegetable = FactoryBot.create(:vegetable, name: 'トマト')
    @step1 = FactoryBot.create(:growing_step, vegetable: @vegetable, step_number: 1, title: '種まき', content: '種をまく')
    sign_in @user
  end

  it 'STEPをチェックすると、保存されてリロード後もチェックが維持されている' do
    visit vegetable_growing_steps_path(@vegetable)

    # チェックされていないことを確認
    expect(page).to have_unchecked_field('STEP 1: 種まき')

    # チェックボックスをクリック（自動送信）
    check 'STEP 1: 種まき'

    # リロードしてもチェックが維持されていることを確認
    visit current_path
    expect(page).to have_checked_field('STEP 1: 種まき')
  end
end
