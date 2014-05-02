class UserVote < ActiveRecord::Base
  validates :user, :link, presence: true
  validates :upvote, inclusion: { in: [true, false] }
  belongs_to :user
  belongs_to :link
end
