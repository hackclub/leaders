class StaticPagesController < ApplicationController
  def index
    if signed_in?
      @clubs = current_user.clubs_api_record
      redirect_to club_path(@clubs.first[:slug]) if @clubs.count == 1
    end
  end
end
