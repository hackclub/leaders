class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :edit]
  before_action :set_all_clubs, only: :index

  # GET /clubs
  def index
    # authorize @clubs
  end

  # GET /clubs/1
  def show
    # authorize @club
  end

  private

  # (max@maxwofford) both of the set_clubs methods are hacks while I build out a clubs model
  def set_all_clubs
    @clubs = clubs
  end

  def set_club
    @club = clubs.find do |club|
      club_slug = club[:high_school_name].gsub(' ', '-')
      club_slug == params[:slug]
    end
  end

  def clubs
    current_user.clubs_api_record
  end
end
