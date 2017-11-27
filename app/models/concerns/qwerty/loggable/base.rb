module Qwerty
  module Loggable::Base
    extend ActiveSupport::Concern

    attr_accessor :log_presentation, :browser, :device

    def to_log_presentation
      {}
    end

    def get_log_changes
      self.reload unless self.destroyed?

      changes = {}
      self.to_log_presentation.each do |key, value|
        if self.log_presentation[key] != value
          changes[key] = value
        end
      end

      changes
    end

    def get_log_data(event_name, params)
      params
    end

    def start_log(request)
      self.log_presentation = self.to_log_presentation
      self.browser = request.headers['Client-Browser']
      self.device = request.headers['Client-Device']
    end

    def done_log(event_name, actioner, params={})
      {
        log_data: self.get_log_data(event_name, params),
        log_changes: self.get_log_changes
      }
    end
  end
end
