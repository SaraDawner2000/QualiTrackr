class PartPolicy < ApplicationPolicy
  attr_reader :current_user, :part

  def initialize(current_user, part)
    @current_user = current_user
    @part = part
  end

  def show?
    true
  end

  def index?
    true
  end

  def remove_drawing?
    update?
  end

  def update?
    true
  end

  def create?
    current_user.role in ["quality_manager", "prod_manager"]
  end

  def destroy?
    current_user.role in ["quality_manager", "prod_manager"]
  end
end
