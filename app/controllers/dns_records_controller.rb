class DnsRecordsController < ApplicationController
  before_action :set_subdomain
  before_action :set_dns_record, only: [:show, :edit]

  def index
    @dns_records = current_user.clubs.map { |c| c.subdomains.map { |s| s.dns_records } }.flatten
  end

  def edit
  end

  def show
  end

  def new
    @dns_record = DnsRecord.new(subdomain: @subdomain)
  end

  def create
    @dns_record = DnsRecord.new(dns_record_params)
    @dns_record.user = current_user
    if @dns_record.save
      render 'dns_records'
    else
      redirect_to :new
    end
  end

  def destroy
    @dns_record = DnsRecord.find(params[:id])
    @subdomain = @dns_record.subdomain
    if @dns_record.destroy
      redirect_to @subdomain
    else
      redirect_to dns_records_path
    end
  end

  private

  def dns_record_params
    params.require(:dns_record).permit(:value, :record_type, :subdomain_id)
  end

  def set_dns_record
    @dns_record = DnsRecord.find(params[:id])
  end

  def set_subdomain
    @subdomain = Subdomain.find do |subdomain|
      subdomain.slug == params[:subdomain_slug]
    end
  end
end
