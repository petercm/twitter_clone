class Following < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validate :may_not_follow_self

  def may_not_follow_self
    errors.add(:followed_id, "can't follow self") if follower_id == followed_id
  end
end
