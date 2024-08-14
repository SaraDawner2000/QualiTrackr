# == Schema Information
#
# Table name: quality_projects
#
#  id                :bigint           not null, primary key
#  part_id           :bigint           not null
#  customer_request  :string
#  purchase_order    :string
#  report_approval   :boolean
#  record_approval   :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  customer_approval :enum
#  customer          :enum             not null
#
class QualityProject < ApplicationRecord
  enum customer_options: { ready: "ready", sent: "sent", approved: "approved", rejected: "rejected" }
  enum customers: { sparky: "sparky", mctracktor: "mctracktor" }

  validates :customer, presence: true

  has_one_attached :inspection_plan
  has_one_attached :assembled_record

  belongs_to :part

  # these scopes are required to filter the view partials for the dashboard
  scope :not_sold, -> { where(purchase_order: nil) }
  scope :sold, -> { where.not(purchase_order: nil) }

  scope :without_inspection_plan, -> { where.missing(:inspection_plan_attachment) }
  scope :with_inspection_plan, -> { joins(:inspection_plan_attachment) }

  scope :report_not_approved, -> { where(report_approval: false) }
  scope :report_approved, -> { where(report_approval: true) }

  scope :part_measured, -> { where("part_id IN (?)", Part.measured.pluck(:id))  }
  scope :part_not_measured, -> { where("part_id IN (?)", Part.not_measured.pluck(:id))  }

  scope :record_not_assembled, -> { where.missing(:assembled_record_attachment) }
  scope :record_assembled, -> { joins(:assembled_record_attachment) }

  scope :record_not_approved, -> { where(record_approval: false) }
  scope :record_approved, -> { where(record_approval: true) }

  scope :with_customer_request, -> { where.not(customer_request: nil) }

  def self.ransackable_attributes(auth_object = nil)
    [  "id", "customer", "number", "part_revision", "customer_request", "purchase_order", "report_approval", "record_approval", "customer_approval"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["part"]
  end
end
