require 'rails_helper'

RSpec.describe StepProgress, type: :model do
  before do
    @step_progress = FactoryBot.build(:step_progress)
  end

  describe 'ステップ進捗の保存' do
    context '保存できる場合' do
      it 'userとgrowing_stepがあれば保存できる' do
        expect(@step_progress).to be_valid
      end
    end

    context '保存できない場合' do
      it 'userが紐づいていないと保存できない' do
        @step_progress.user = nil
        @step_progress.valid?
        expect(@step_progress.errors.full_messages).to include('User must exist')
      end

      it 'growing_stepが紐づいていないと保存できない' do
        @step_progress.growing_step = nil
        @step_progress.valid?
        expect(@step_progress.errors.full_messages).to include('Growing step must exist')
      end
    end
  end
end
