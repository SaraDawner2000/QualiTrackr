class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."

      redirect_back fallback_location: root_url
    end
end
