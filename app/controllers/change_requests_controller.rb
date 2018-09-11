class ChangeRequestsController < ApplicationController
  before_action :set_subdomain

  def index
    @new_change_request = ChangeRequest.new(subdomain: @subdomain)
  end

  def create
    @change_request = ChangeRequest.new(change_request_params)
  end

  private

  def change_request_params
    params.require(:change_request).permit(:value, :record_type, :club_id, :subdomain_id)
  end

  def set_subdomain
    @subdomain = Subdomain.find do |subdomain|
      subdomain.slug == params[:subdomain_slug]
    end
  end
end
