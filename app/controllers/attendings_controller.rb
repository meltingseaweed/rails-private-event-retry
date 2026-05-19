class AttendingsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])

    current_user.attendings.create!(attended_events: @event)
    redirect_back fallback_location: root_url, notice: "Joined succesfully!"
  end
end
