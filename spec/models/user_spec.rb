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

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without a name' do
    subject.name = nil
    should be_invalid
  end

  it 'is invalid without an email' do
    subject.email = nil
    should be_invalid
  end

  it 'is invalid without a poniverse id' do
    subject.poniverse_id = nil
    should be_invalid
  end

  it 'is invalid when a user with the same exists' do
    create :user, name: subject.name
    should be_invalid
  end

  it 'is invalid when a user with the same email exists' do
    create :user, email: subject.email
    should be_invalid
  end
end
