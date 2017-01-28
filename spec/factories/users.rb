# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  email        :string           not null
#  poniverse_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_name   (name) UNIQUE
#

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString"
    poniverse_id 1
  end
end
