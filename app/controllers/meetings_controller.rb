class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def show
    authorize @meeting
  end

  def new
    @club = Club.find_by(slug: params[:club_slug])
    @meeting = Meeting.new(club: @club)
    authorize @meeting
  end

  def edit
    authorize @meeting
  end

  def create
    @meeting = Meeting.new(meeting_params)
    authorize @meeting

    if @meeting.save
      redirect_to @meeting.club, notice: 'Meeting was successfully recorded.'
    else
      render :new
    end
  end

  def update
    authorize @meeting
    if @meeting.update(meeting_params)
      redirect_to @meeting, notice: 'Meeting was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    club = @meeting.club
    authorize @meeting
    @meeting.destroy
    redirect_to club, notice: 'Meeting was successfully destroyed.'
  end
  private
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:start_time, :attendee_count, :club_id)
    end
end
