class StaticPagesController < ApplicationController
  def index
    if signed_in?
      @clubs = current_user.clubs
      redirect_to @clubs.first if @clubs.count == 1
    end
  end
end
