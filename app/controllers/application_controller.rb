# frozen_string_literal: true
class ApplicationController < ActionController::API
  include Pundit

  if Rails.env.development? || Rails.env.test?
    after_action :verify_authorized
    after_action :verify_policy_scoped, except: :create
  end

  rescue_from Pundit::NotAuthorizedError do
    head current_user.nil? ? :unauthorized : :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { errors: { error.record => ['not found'] } }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActiveRecord::RecordNotDestroyed do |error|
    render json: { errors: error.record.errors }, status: :unprocessable_entity
  end

protected

  def current_user
    nil # TODO
  end

  def meta_for(relation)
    {
      page:  relation.current_page,
      next:  relation.next_page,
      prev:  relation.prev_page,
      size:  relation.length,
      count: relation.total_count,
      pages: relation.total_pages
    }
  end
end
