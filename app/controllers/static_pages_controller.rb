class StaticPagesController < ApplicationController
  def index
    if signed_in?
      @clubs = User.last.club_api_record
    end
  end
end
