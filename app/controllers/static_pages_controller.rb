class StaticPagesController < ApplicationController
  before_action :signed_in_user

  def index
    @clubs = current_user.clubs
    skip_authorization
    redirect_to @clubs.first if @clubs.count == 1
  end
end
