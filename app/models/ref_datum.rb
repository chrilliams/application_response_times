class RefDatum < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :hourlies, dependent: :destroy
  belongs_to :business_system

  before_destroy :ensure_not_referenced_by_any_event

  def self.unique_business_service
    ## not current used
    RefDatum.pluck(:description).uniq
  end

  private

  def ensure_not_referenced_by_any_event
    if events.empty?
      return true
    else
      return false
    end
  end
end
