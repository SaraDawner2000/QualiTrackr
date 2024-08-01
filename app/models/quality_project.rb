class QualityProject < ApplicationRecord
  enum customer_options: { unready: "unready", ready: "ready", sent: "sent", approved: "approved", rejected: "rejected" }
  enum customers: { sparky: "sparky", mctracktor: "mctracktor" }
  validates :customer, presence: true

  belongs_to :part

  def self.ransackable_attributes(auth_object = nil)
    ["part_id", "part_number", "assembled_record", "customer", "customer_options", "id", "inspection_plan", "customer_request", "purchase_order"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["part"]
  end

  scope :not_sold, -> { where(purchase_order: nil) }
  scope :sold, -> { where.not(purchase_order: nil) }

  scope :without_inspection_plan, -> { where(inspection_plan: nil) }
  scope :with_inspection_plan, -> { where.not(inspection_plan: nil) }

  scope :report_not_approved, -> { where(report_approval: false) }
  scope :report_approved, -> { where(report_approval: true) }

  scope :part_measured, -> { where("part_id IN (?)", Part.measured.pluck(:id))  }
  scope :part_not_measured, -> { where("part_id IN (?)", Part.not_measured.pluck(:id))  }

  scope :record_not_assembled, -> { where(assembled_record: nil) }
  scope :record_assembled, -> { where.not(assembled_record: nil) }

  scope :record_not_approved, -> { where(record_approval: false) }
  scope :record_approved, -> { where(record_approval: true) }

  scope :with_customer_request, -> { where.not(customer_request: nil) }
end
