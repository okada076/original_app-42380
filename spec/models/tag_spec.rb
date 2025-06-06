require 'rails_helper'

RSpec.describe Tag, type: :model do
  it '名前があれば有効である' do
    tag = build(:tag, name: 'トマト')
    expect(tag).to be_valid
  end

  it '名前が空だと無効である' do
    tag = build(:tag, name: '')
    expect(tag).not_to be_valid
  end
end
