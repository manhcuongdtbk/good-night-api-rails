class User < ApplicationRecord
  has_many :sleeps, dependent: :destroy
  has_many :operations
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy,
                                  inverse_of: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy,
                                   inverse_of: :followed
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end
end
