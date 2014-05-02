# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  body              :text             not null
#  author_id         :integer          not null
#  link_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Comment < ActiveRecord::Base
  validates :body, :author, :link, presence: true

  belongs_to :author, class_name: 'User'
  belongs_to :link
  belongs_to :parent_comment, class_name: 'Comment'

  has_many :child_comments, class_name: 'Comment',
           foreign_key: :parent_comment_id
end
