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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentences }
    association :author, factory: :user

    factory :child_comment do
      association :parent_comment, factory: :comment
    end
  end
end
