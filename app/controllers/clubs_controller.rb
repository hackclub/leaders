class ClubsController < ApplicationController

  # GET /clubs
  def index
    @clubs = current_user.clubs
    # authorize @clubs
  end

  # GET /clubs/1
  def show
    @club = Club.find_by(slug: params[:slug])
    @subdomains = @club.subdomains
    # authorize @club
  end
end
