class SubdomainsController < ApplicationController
  before_action :set_subdomain, only: [:show, :update]
  def show
  end

  def update
     if @subdomain.update(subdomain_params)
       redirect_to @subdomain
     end
  end

  def create
    @subdomain = Subdomain.create(subdomain_params)
    if @subdomain.save
      redirect_to @subdomain
    end
  end

  private

  def set_subdomain
    @subdomain = Subdomain.find do |subdomain|
      subdomain.slug == params[:slug]
    end
  end

  def subdomain_params
    params.require(:subdomain).permit(:name, :slug, :club_id)
  end
end
