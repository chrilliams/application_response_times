class BusinessSystem < ActiveRecord::Base
  has_many :ref_datum, dependent: :destroy
  has_many :log_file, dependent: :destroy
  has_many :events, through: :ref_datum
  accepts_nested_attributes_for :ref_datum, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :log_file, reject_if: :all_blank

  validates :business_service_name, :metric_id, :current_sla_kpi, :target, presence: true
end
