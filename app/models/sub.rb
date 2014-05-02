# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  moderator_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, :moderator, presence: true

  belongs_to :moderator, class_name: "User"
  has_many :link_subs
  has_many :links, through: :link_subs, source: :link, inverse_of: :parent_subs
end
