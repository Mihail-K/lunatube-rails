# frozen_string_literal: true
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
    name { Faker::Internet.user_name }
    email { Faker::Internet.email }
    poniverse_id 1
  end
end
