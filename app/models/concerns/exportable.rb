module Exportable
  extend ActiveSupport::Concern

  module ClassMethods
    def downloadable_attribute_keys
      keys = {}
      self.all.each do |record|
        if record.to_downloadable_attributes
          keys = record.to_downloadable_attributes.keys
          break
        end
      end
      return keys
    end

    def export_and_send_to(user)
      Thread.new do
        RecordsDownloadMailer.send_email(model_name: self.to_s, receiver: user.email).deliver
      end
    end
  end
end
