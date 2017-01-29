# frozen_string_literal: true
class ApplicationPolicy
  module Common
    extend ActiveSupport::Concern

    def authenticated?
      current_user.present?
    end

    def guest?
      !authenticated?
    end
  end

  include Common

  attr_reader :current_user
  attr_reader :record

  def initialize(current_user, record)
    @current_user = current_user
    @record       = record
  end

  def index?
    false
  end

  def show?
    scope.exists?(id: record)
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def scope
    scope = record.is_a?(Class) ? record : record.class
    Pundit.policy_scope!(current_user, scope)
  end

  class Scope
    include Common

    attr_reader :current_user
    attr_reader :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope        = scope
    end

    def resolve
      scope
    end
  end
end
