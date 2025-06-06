require 'rails_helper'

RSpec.describe PostTag, type: :model do
  it 'postとtagがあれば有効である' do
    post_tag = build(:post_tag)
    expect(post_tag).to be_valid
  end

  it 'postがなければ無効である' do
    post_tag = build(:post_tag, post: nil)
    expect(post_tag).not_to be_valid
  end

  it 'tagがなければ無効である' do
    post_tag = build(:post_tag, tag: nil)
    expect(post_tag).not_to be_valid
  end
end
