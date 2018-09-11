class ChangeRequestsController < ApplicationController
  before_action :set_subdomain

  def index
    @new_change_request = ChangeRequest.new(subdomain: @subdomain, user: current_user)
    @change_requests = @subdomain.change_requests
  end

  def create
    @change_request = ChangeRequest.new(change_request_params)
    if @change_request.save
      redirect_to subdomain_change_requests_path(@subdomain)
    else
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @change_request = ChangeRequest.find(params[:id])
    if @change_request.destroy
      redirect_to subdomain_change_requests_path(@subdomain)
    else
      render subdomain_change_requests_path(@subdomain)
    end
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
