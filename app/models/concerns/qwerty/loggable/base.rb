module Qwerty
  module Loggable::Base
    extend ActiveSupport::Concern

    attr_accessor :log_presentation

    def to_log_presentation
      {}
    end

    def get_log_changes
      self.reload

      changes = {}
      self.to_log_presentation.each do |key, value|
        if self.log_presentation[key] != value
          changes[key] = value
        end
      end

      changes
    end

    def get_log_data(event_name, params)
      {}
    end

    def start_log
      self.log_presentation = self.to_log_presentation
    end

    def done_log(event_name, actioner, params={})
      {
        log_data: self.get_log_data(event_name, params),
        log_changes: self.get_log_changes
      }
    end
  end
end
