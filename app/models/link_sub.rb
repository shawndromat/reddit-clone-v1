# == Schema Information
#
# Table name: link_subs
#
#  id         :integer          not null, primary key
#  link_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class LinkSub < ActiveRecord::Base
  belongs_to :link
  belongs_to :sub
end
