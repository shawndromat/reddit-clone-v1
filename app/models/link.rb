# == Schema Information
#
# Table name: links
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  url          :string(255)      not null
#  text         :text
#  created_at   :datetime
#  updated_at   :datetime
#  submitter_id :integer
#

class Link < ActiveRecord::Base
  validates :title, :url, :parent_subs, presence: true

  has_many :link_subs
  has_many :parent_subs, through: :link_subs, source: :sub
  belongs_to :submitter, class_name: 'User'
  has_many :comments
  has_many :user_votes

  def comments_by_parent_id
    parent_hash = Hash.new { |h, k| h[k] = [] }
    comments.each do |comment|
      parent_hash[comment.parent_comment_id] << comment
    end

    parent_hash
  end

  def vote_count
    votes = user_votes
    votes.inject(0) do |accum, vote|
      vote.upvote ? accum + 1 : accum -1
    end
  end
end