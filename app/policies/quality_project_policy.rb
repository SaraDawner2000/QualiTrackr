class QualityProjectPolicy < ApplicationPolicy
  attr_reader :current_user, :quality_project

  def initialize(current_user, quality_project)
    @current_user = current_user
    @quality_project = quality_project
  end

  def show?
    true
  end

  def index?
    true
  end

  def remove_inspection_plan?
    update?
  end

  def remove_assembled_record?
    update?
  end

  def update?
    current_user.role in ["quality_manager", "prod_manager", "quality_admin"]
  end

  def create?
    current_user.role in ["quality_manager", "prod_manager"]
  end

  def destroy?
    current_user.role in ["quality_manager", "prod_manager"]
  end
end
