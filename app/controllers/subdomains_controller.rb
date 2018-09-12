class SubdomainsController < ApplicationController
  before_action :set_subdomain, only: [:edit, :update, :create, :show]

  def index
    @subdomains = current_user.admin? ? Subdomain.all : current_user.clubs.map{ |c| c.subdomains }.flatten
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
    @subdomain = Subdomain.find_by(name: params[:slug])
  end

  def subdomain_params
    params.require(:subdomain).permit(:name, :slug, :club_id)
  end
end
