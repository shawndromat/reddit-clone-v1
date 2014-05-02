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

require 'spec_helper'

describe Comment do
  subject(:comment) { build(:comment) }

  # it { should be_valid }
  it { should validate_presence_of(:body) }
  it { should belong_to(:author) }
  # it { should belong_to(:link) }

  let(:child_comm) { build(:child_comment) }

  describe "child comment" do
    it "should have a parent comment" do
      expect(child_comm.parent_comment).to_not be_nil
    end
  end


end
