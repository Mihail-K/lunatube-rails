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

class User < ApplicationRecord
  validates :name, :email, :poniverse_id, presence: true

  validates :name, uniqueness: true, if: :name_changed?
  validates :email, uniqueness: true, if: :email_changed?
end
