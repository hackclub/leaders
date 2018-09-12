class SubdomainsController < ApplicationController
  before_action :set_subdomain, only: [:edit, :update, :create, :show]

  def index
    @subdomain = current_user.admin? ? Subdomain.all : current_user.clubs.subdomains
  end

  def show
  end

  def new
    @subdomain = Subdomain.new
  end

  def create
    @subdomain = Subdomain.new(subdomain_params)
    if @subdomain.save
      redirect_to @subdomain
    else
      render :new
    end
  end

  def edit
  end

  def update
     if @subdomain.update(subdomain_params)
       redirect_to @subdomain.club
     else
       render :edit
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
