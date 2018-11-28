class ClubsController < ApplicationController
  before_action :signed_in_user

  # GET /clubs
  def index
    @clubs = current_user.clubs
    authorize Club

    if @clubs.count == 1
      redirect_to @clubs.first
    else
      render :index
    end
  end

  # GET /clubs/1
  def show
    @club = Club.find_by(slug: params[:slug])
    authorize @club
    @api_record ||= ApiService.get_club(@club.api_id, current_user.api_access_token)
    @subdomains = @club.subdomains
    @meetings = @club.meetings
    @club = OpenStruct.new @club.attributes.reverse_merge!(@api_record)
    @email_on_check_in = current_user.email_on_check_in
  end
end
