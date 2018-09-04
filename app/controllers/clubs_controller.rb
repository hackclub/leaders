class ClubsController < ApplicationController
  before_action :set_all_clubs
  before_action :set_club, only: [:show, :edit]

  # GET /clubs
  def index
    authorize @clubs
  end

  # GET /clubs/1
  def show
    authorize @club
  end

  private

  # (max@maxwofford) both of the set_clubs methods are hacks while I build out a clubs model
  def set_all_clubs
    @clubs = current_user.clubs_api_record
  end

  def set_club
    @club = @clubs.find(id: params[:id])
  end
end
