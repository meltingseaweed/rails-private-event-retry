class UsersController < ApplicationController
  before_action :require_login, only: [ :show ]

  def show
    @user = User.find(params[:id])
  end

  def destroy
    Attending.where(attendee_id: current_user.id, attended_events_id: params[:event_id]).destroy_all
    redirect_to user_path, status: :see_other, notice: "Participation in the event successfully withdrawn."
  end
end
