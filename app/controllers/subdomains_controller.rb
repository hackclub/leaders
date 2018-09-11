class SubdomainsController < ApplicationController
  def show
  end

  def create
    @subdomain = Subdomain.create(subdomain_params)
    if @subdomain.save
      redirect_to @subdomain
    else
      render
    end
  end

  private

  def subdomain_params
    params.require(:subdomain).permit(:name, :club_id)
  end
end
