class StaticPagesController < ApplicationController
  def index
    if signed_in?
      @clubs = User.last.clubs_api_record
    end
  end
end
