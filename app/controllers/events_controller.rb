class EventsController < ApplicationController
  before_action :require_login
  before_action :is_authorised, only: [ :show ]
  before_action :is_creator?, only: [ :show ]
  def index
    @events = Event.all
    today = Date.today
    @upcoming = Event.upcoming_events(today)
    @past = Event.past_events(today)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to root_path, notice: "Event created successfully :)"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
    current_event
    @all_users = User.all
  end

  def edit
    current_event
  end

  def update
    current_event
    if @event.update(event_params)
      redirect_to root_path, notice: "Event updated successfully :)"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_event
    if @event.invitations.any?
        Invitation.where(invited_events_id: @event.id).destroy_all
    end
    if @event.attendings.any?
        Attending.where(attended_events_id: @event.id).destroy_all
    end
    @event.destroy
    redirect_to root_path, status: :see_other, notice: "The event was successfully deleted"
  end

  private
  def event_params
    params.expect(event: [ :event_date, :location, :visibility ])
  end

  def current_event
    @event = Event.find(params[:id])
  end

  def is_creator?
    if @event.creator_id == current_user.id
      @creator = true
    else
      @creator = false
    end
  end

  def is_authorised
    current_event
    if @event.invited_users.where(id: current_user.id).any? || @event.visibility == "public_event"
      true
    elsif @event.creator_id != current_user.id
      flash[:notice] = "Sorry, you must be invited or the event creator to view this event."
      redirect_to root_path
    end
  end
end
