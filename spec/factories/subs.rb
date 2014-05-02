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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sub_names = %w[Cupcakes Cats TIL Fitness Kniting LearnProgramming ASOIAF]
  factory :sub do
    sequence(:name) { |num| "#{sub_names.sample} #{num}" }
    association :moderator, factory: :user
  end
end
