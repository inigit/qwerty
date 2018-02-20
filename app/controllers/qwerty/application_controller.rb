module Qwerty
  class ApplicationController < ::ApplicationController
    protected

    def q_params
      q = params[:q]
      if q.is_a? String
        q = JSON.parse(q)
      end
      q || {}
    end
  end
end
