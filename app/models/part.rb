class Part < ApplicationRecord
  has_one_attached :drawing

  validates :part_number, uniqueness: { scope: :revision, message: "part number of this revision already exists." }
  validates :part_number, :revision, presence: true

  has_one :quality_project

  has_many :children, foreign_key: :parent_id, class_name: "Subcomponent"
  has_many :parents, foreign_key: :child_id, class_name: "Subcomponent"

  has_many :child_parts, through: :children, source: :child
  has_many :parent_parts, through: :parents, source: :parent

  scope :top_parts, -> { where.not(id: Subcomponent.pluck(:child_id).uniq) }
  scope :top_parts_with_subcomponents, -> { where(base_material: "subcomponent") }
  scope :subcomponents, -> { where(id: Subcomponent.pluck(:child_id).uniq) }
  scope :single_or_child_parts, -> { where.not(base_material: "subcomponent") }

  scope :not_measured, -> { where(measured_status: false) }
  scope :ready_to_be_measured, -> {
     joins(:quality_project)
     .where(measured_status: false)
     .where.not(drawing: nil)
     .where.not(quality_project: { inspection_plan: nil })
   }
  scope :measured, -> { where(measured_status: true) }


  def measured?
    self.measured_status == true
  end

  def self.ransackable_attributes(auth_object = nil)
    ["part_number", "revision", "drawing", "base_material", "finish", "measured_status"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["quality_project"]
  end
end
