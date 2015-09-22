class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets

  has_many :follower_links, class_name:  "Following",
    foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_links, source: :follower

  has_many :following_links, class_name:  "Following",
    foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :following_links, source: :followed

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  def follow(user)
    following_links.create(followed_id: user.id)
  end

  def unfollow(user)
    following_links.find_by(followed_id: user.id).destroy
  end

  def feed
    Tweet.where(user_id: following_ids + [id])
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end

end
