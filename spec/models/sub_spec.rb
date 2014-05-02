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

require 'spec_helper'

describe Sub do
  subject(:sub) { build(:sub) }

  it { should be_valid }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:moderator) }

  describe "associations" do
    it { should belong_to(:moderator) }
  end

  describe "error messages" do
    it "should raise name blank error" do
      sub.name = nil
      sub.save
      expect(sub.errors.full_messages).to include("Name can't be blank")
    end

    let(:sub2) { create(:sub) }

    it "should raise name taken error" do
      sub.name = sub2.name
      sub.save
      expect(sub.errors.full_messages).to include("Name has already been taken")
    end

    it "should raise no moderator error" do
      sub.moderator_id = nil
      sub.save
      expect(sub.errors.full_messages).to include("Moderator can't be blank")
    end
  end
end
