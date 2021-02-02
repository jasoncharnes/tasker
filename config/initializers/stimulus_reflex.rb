# frozen_string_literal: true

StimulusReflex.configure do |config|
  # Enable/disable exiting / warning when the sanity checks fail options:
  # `:exit` or `:warn` or `:ignore`

  config.on_failed_sanity_checks = :ignore

  # Override the parent class that the StimulusReflex ActionCable channel inherits from

  # config.parent_channel = "ApplicationCable::Channel"

  # Customize server-side Reflex logging format, with optional colorization:
  # Available tokens: session_id, session_id_full, reflex_info, operation, reflex_id, reflex_id_full, mode, selector, operation_counter, connection_id, connection_id_full, timestamp
  # Available colors: red, green, yellow, blue, magenta, cyan, white
  # You can also use attributes from your ActionCable Connection's identifiers that resolve to valid ActiveRecord models
  # eg. if your connection is `identified_by :current_user` and your User model has an email attribute, you can access r.email (it will display `-` if the user isn't logged in)

  # config.logging = proc { "[#{session_id}] #{operation_counter.magenta} #{reflex_info.green} -> #{selector.cyan} via #{mode} Morph (#{operation.yellow})" }
end
