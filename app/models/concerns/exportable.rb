module Exportable
  extend ActiveSupport::Concern

  module ClassMethods
    def downloadable_attribute_keys
      keys = {}
      self.find_each do |record|
        if record.to_downloadable_attributes
          keys = record.to_downloadable_attributes.keys
          break
        end
      end
      return keys
    end

    def export_and_send_to(user, records)
      Thread.new do
        RecordsDownloadMailer.send_email(model_name: self.to_s, records: records, receiver: user.email).deliver
      end
    end
  end
end
