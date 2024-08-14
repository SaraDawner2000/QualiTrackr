# == Schema Information
#
# Table name: parts
#
#  id              :bigint           not null, primary key
#  number          :string           not null
#  revision        :string           not null
#  job             :string
#  base_material   :string
#  finish          :string
#  measured_status :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Part < ApplicationRecord
  validates :number, uniqueness: { scope: :revision, message: "part number of this revision already exists." }
  validates :number, :revision, presence: true

  has_one_attached :drawing

  has_one :quality_project, dependent: :destroy

  has_many :children, foreign_key: :parent_id, class_name: "Subcomponent", dependent: :destroy
  has_many :parents, foreign_key: :child_id, class_name: "Subcomponent"

  has_many :child_parts, through: :children, source: :child, dependent: :destroy
  has_many :parent_parts, through: :parents, source: :parent

  # these scopes are requried to differentiate top parts (parts with associated quality projects) from subcomponents (parts with associated top parts)
  scope :top_parts, -> { where.not(id: Subcomponent.pluck(:child_id).uniq) }
  scope :top_parts_with_subcomponents, -> { where(base_material: "subcomponent") }
  scope :subcomponents, -> { where(id: Subcomponent.pluck(:child_id).uniq) }
  scope :single_or_child_parts, -> { where.not(base_material: "subcomponent") }

  scope :drawing_attached, -> { joins(:drawing_attachment) }
  scope :drawing_not_attached, -> { left_joins(:drawing_attachment).where(active_storage_attachments: { id: nil }) }

  scope :with_inspection_plan, -> { joins(quality_project: :inspection_plan_attachment) }

  scope :not_measured, -> { where(measured_status: false) }
  scope :measured, -> { where(measured_status: true) }

  def self.ransackable_attributes(auth_object = nil)
    ["number", "revision", "base_material", "finish", "measured_status"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["quality_project"]
  end
end
