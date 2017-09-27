module Qwerty
  module Api::Loggable
    extend ActiveSupport::Concern

    def start_log(actionee)
      actionee.start_log
    end

    def done_log(session_token, event_name, actioner, actionee, log_data={})
      log_params = actionee.done_log(event_name, actioner, log_data)
      Rails.logger.info log_params.inspect.blue
      self.post_log(session_token, event_name, actioner, actionee, log_params[:log_data], log_params[:log_changes])
    end

    def post_log(session_token, event_name, actioner, actionee, log_data, log_changes)
      begin
        response = RestClient.post(
          "#{Rails.application.secrets.log_server_url}/admin/logs",
          {
            'X-Authentication-Token': session_token,
            log_type: actionee.log_type,
            log_action: event_name,
            log_user: actioner.id,
            log_id: actionee.id,
            log_remarks: params[:log_remarks],
            log_data: log_data,
            log_changes: log_changes,
          }
        )
      rescue Exception => e
        Rails.logger.error e.inspect.red
      end
    end
  end
end
