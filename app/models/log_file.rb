class LogFile < ActiveRecord::Base
  belongs_to :business_system
  validates :file_name, :line_format, :fields, presence: true
end
