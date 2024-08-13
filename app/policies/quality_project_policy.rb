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
    true
  end

  def create?
    ["quality_manager", "prod_manager"].include?(current_user.role)
  end

  def destroy?
    ["quality_manager", "prod_manager"].include?(current_user.role)
  end
end
