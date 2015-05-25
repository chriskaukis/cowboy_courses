class LoggedAction < ActiveRecord::Base
  store_accessor :row_data
  store_accessor :changed_fields
end