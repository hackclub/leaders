class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :edit]

  # GET /clubs
  def index
    @clubs = current_user.clubs
    # authorize @clubs
  end

  # GET /clubs/1
  def show
    # authorize @club
  end

  private

  def set_club
    @club = current_user.club_for_slug(params[:slug])
    @subdomain = Subdomain.find_or_initialize_by(club_id: @club[:id])
  end
end
