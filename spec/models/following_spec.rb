require 'rails_helper'

RSpec.describe Following, type: :model do
  before :each do
    @following = Following.new(follower_id: 1, followed_id: 2)
  end

  it "should be valid" do
    expect(@following.valid?).to be_truthy
  end

  it "should require a follower_id" do
    @following.follower_id = nil
    expect(@following.valid?).to be_falsy
  end

  it "should require a followed_id" do
    @following.followed_id = nil
    expect(@following.valid?).to be_falsy
  end
end
