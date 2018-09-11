class ChangeRequestsController < ApplicationController
  before_action :set_subdomain

  def index
    @new_change_request = ChangeRequest.new(subdomain: @subdomain, user: current_user)
    @change_requests = @subdomain.change_requests
  end

  def create
    @change_request = ChangeRequest.new(change_request_params)
  end

  private

  def change_request_params
    params.require(:change_request).permit(:value, :record_type, :subdomain_id, :user_id)
  end

  def set_subdomain
    @subdomain = Subdomain.find do |subdomain|
      subdomain.slug == params[:subdomain_slug]
    end
  end
end
