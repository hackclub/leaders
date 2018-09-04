class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :edit]

  # GET /clubs
  def index
    @clubs = Club.all
    authorize @clubs
  end

  # GET /clubs/1
  def show
    authorize @club
  end

  # GET /clubs/1/edit
  def edit
    authorize @club
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end
end
