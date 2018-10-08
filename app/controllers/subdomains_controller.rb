class SubdomainsController < ApplicationController
  before_action :signed_in_user
  before_action :set_subdomain, only: [:edit, :update, :show, :destroy]

  def index
    @subdomains = current_user.admin? ? Subdomain.all : current_user.clubs.map{ |c| c.subdomains }.flatten
    authorize Subdomain
  end

  def show
    @new_dns_record = DnsRecord.new(subdomain: @subdomain)
    @status = @subdomain.status
  end

  def new
    @club = Club.find(params[:club_id]) if params[:club_id]
    @subdomain = Subdomain.new(club: @club)
    authorize @subdomain
  end

  def create
    @subdomain = Subdomain.new(subdomain_params)
    authorize @subdomain
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
      redirect_to @subdomain
    else
      render :edit
    end
  end

  def destroy
    club = @subdomain.club
    @subdomain.dns_records.update_all(deleted_at: Time.now)
    @subdomain.create_pr
    if @subdomain.update(deleted_at: Time.now)
      redirect_to club
    else
      render :show
    end
  end

  private

  def subdomain_params
    params.require(:subdomain).permit(:name, :slug, :club_id)
  end

  def set_subdomain
    @subdomain = Subdomain.find_by(name: params[:slug])
    authorize @subdomain
  end
end
