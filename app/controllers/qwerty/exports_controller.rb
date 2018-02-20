module Qwerty
  class ExportsController < ::Api::BaseController
    def download
      model = params[:id].camelcase.constantize
      records = model.ransack(q_params).result(distinct: true)
      head :ok if model.export_and_send_to(current_user, records)
    end
  end
end
