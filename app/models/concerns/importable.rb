module Importable
  extend ActiveSupport::Concern

  def get_attribute_from_xlsx_row(header_row:, row:, key:)
    row[header_row.find_index(key.try(:strip))].try(:strip) if header_row.find_index(key.try(:strip))
  end

  module ClassMethods
  end
end
