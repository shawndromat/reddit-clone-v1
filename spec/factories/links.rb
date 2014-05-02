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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    title { Faker::Commerce.product_name }
    url { Faker::Internet.url }
    # association :parent_subs, [factory: :sub]
  end
end
