# frozen_string_literal: true
require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module LunatubeRails
  class Application < Rails::Application
    config.active_record.schema_format = :sql
    config.api_only = true
    config.generators do |g|
      g.test_framework      :rspec
      g.fixture_replacement :factory_girl
    end

    ActiveModelSerializers.config.adapter = :json
  end
end
