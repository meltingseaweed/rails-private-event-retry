class InvitationsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])

    @user.invitations.create!(invited_events: @event)
    redirect_back fallback_location: root_url, notice: "Invitation successful"
  end
end
