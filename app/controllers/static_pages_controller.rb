class StaticPagesController < ApplicationController
  def index
    if signed_in?
      @clubs = User.last.clubs_api_record
      redirect_to club_path(@clubs.first[:slug]) if @clubs.count == 1
    end
  end
end
