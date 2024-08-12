class Admin::RegistrationsController < ApplicationController
  class Admin::RegistrationsController < ApplicationController
    before_action :authenticate_admin!

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to dashboard_path, notice: "User successfully created."
      else
        render :new, alert: "Failed to create new user"
      end
    end

    private
      def user_params
        params.require(:user).permit(:email, :password, :username, :role)
      end

      def authenticate_admin!
        unless current_user.admin?
          redirect_to dashboard_path, alert: "Not authorized"
        end
      end
  end
end
