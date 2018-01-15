require 'ipaddr'

module Qwerty
  module Loggable::Base
    extend ActiveSupport::Concern

    attr_accessor :log_presentation, :browser, :device, :ip_address, :country_from_ip

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
      self.ip_address = request.remote_ip
      # if Geocoder
      #   self.country_from_ip = Geocoder.search(self.ip_address).first.try{data['country_name']}
      # end
      self.country_from_ip = get_location_from_ip_address(self.ip_address)
    end

    def done_log(event_name, actioner, params={})
      {
        log_data: self.get_log_data(event_name, params),
        log_changes: self.get_log_changes
      }
    end


    def get_location_from_ip_address(ip_address)
      ip = IPAddr.new(ip_address)
      if ip.ipv4?
        record = Ipv4.find_by_sql(["SELECT * FROM ipv4s WHERE ipv4s.from_ip <= inet ? AND ipv4s.to_ip >= inet ?", ip_address, ip_address]).first
        record
      elsif ip.ipv6?
        record = Ipv6.find_by_sql(["SELECT * FROM ipv6s WHERE ipv6s.from_ip <= inet ? AND ipv6s.to_ip >= inet ?", ip_address, ip_address]).first
        record
      else
        nil
      end
    end
  end
end
