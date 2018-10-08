class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper

  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ApiService::AuthorizationInvalid , with: :api_auth_invalid

  private

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(root_path)
  end

  def api_auth_invalid
    flash[:error] = 'Your authorization is invalid or expired.'
    redirect_to(auth_users_path)
  end
end
