class SubdomainsController < ApplicationController
  before_action :set_subdomain, only: [:update]

  def update
     if @subdomain.update(subdomain_params)
       redirect_to @subdomain.club
     else
       render @subdomain.club
     end
  end

  def create
    @subdomain = Subdomain.new(subdomain_params)
    if @subdomain.save
      redirect_to subdomain_change_requests_path(@subdomain)
    else
      @club = current_user.club_for_id(@subdomain.club_id)
      render 'clubs/show', slug: @club[:slug]
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
