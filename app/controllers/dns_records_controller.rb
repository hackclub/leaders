class DnsRecordsController < ApplicationController
  before_action :signed_in_user
  before_action :set_dns_record, only: [:edit, :update, :show, :destroy]

  def index
    authorize DnsRecord

    @dns_records = current_user.clubs.map { |c| c.subdomains.map { |s| s.dns_records } }.flatten
  end

  def show
  end

  def edit
  end

  def update
    if @dns_record.update(dns_record_params)
      redirect_to @dns_record.subdomain
    else
      render :edit
    end
  end

  def new
    @dns_record = DnsRecord.new(subdomain: @subdomain)
  end

  def create
    @dns_record = DnsRecord.new(dns_record_params)
    @dns_record.user = current_user

    authorize @dns_record

    if @dns_record.save
      redirect_to @dns_record.subdomain
    else
      render :new
    end
  end

  def destroy
    @subdomain = @dns_record.subdomain
    if @dns_record.update(deleted_at: Time.now)
      redirect_to @subdomain
    else
      render :show
    end
  end

  private

  def dns_record_params
    params.require(:dns_record).permit(:value, :record_type, :subdomain_id)
  end

  def set_dns_record
    @dns_record = DnsRecord.find(params[:id])
    authorize @dns_record
  end
end
