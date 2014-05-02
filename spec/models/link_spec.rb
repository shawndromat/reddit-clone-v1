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

require 'spec_helper'

describe Link do
  subject(:link) { build(:link) }

  # it { should be_valid }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }
  it { should have_many(:parent_subs) }

  describe "error messages" do
    it "should raise errors" do
      link.title = ""
      link.url = ""
      link.save

      expect(link.errors.full_messages).to include("Title can't be blank")
      expect(link.errors.full_messages).to include("Url can't be blank")
    end
  end
end
