# frozen_string_literal: true
class UserSerializer < ApplicationSerializer
  attribute :id
  attribute :name
  attribute :created_at
  attribute :updated_at
end
