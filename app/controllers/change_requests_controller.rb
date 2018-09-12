class ChangeRequestsController < ApplicationController
  before_action :set_subdomain
  before_action :set_change_request, only: [:show, :edit]

  def index
    @change_requests = current_user.clubs.map { |c| c.subdomains.map { |s| s.change_requests } }.flatten
  end

  def edit
  end

  def show
  end

  def new
    @change_request = ChangeRequest.new(subdomain: @subdomain)
  end

  def create
    @change_request = ChangeRequest.new(change_request_params)
    @change_request.user = current_user
    if @change_request.save
      render @change_request
    else
      redirect_to :new
    end
  end

  def destroy
    @change_request = ChangeRequest.find(params[:id])
    @subdomain = @change_request.subdomain
    if @change_request.destroy
      redirect_to @subdomain
    else
      redirect_to @change_request
    end
  end

  private

  def change_request_params
    params.require(:change_request).permit(:value, :record_type, :subdomain_id)
  end

  def set_change_request
    @change_request = ChangeRequest.find(params[:id])
  end

  def set_subdomain
    @subdomain = Subdomain.find do |subdomain|
      subdomain.slug == params[:subdomain_slug]
    end
  end
end
