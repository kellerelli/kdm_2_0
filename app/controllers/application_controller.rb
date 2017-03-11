class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def authenticate_with_token!
    unless current_user.present?
      respond_to do |format|
        format.html { redirect_to login_path, notice: 'User not logged in' }
        format.json { render json: { errors: "Not authenticated" }, status: :unauthorized }
      end
    end
  end
end
