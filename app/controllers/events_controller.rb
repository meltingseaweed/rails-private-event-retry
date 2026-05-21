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
    @events = Event.new
  end

  def create
    @events = current_user.events.build(event_params)
    if @events.save
      redirect_to root_path, notice: "Event created successfully :)"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
    current_event
    @all_users = User.all
  end

  private
  def event_params
    params.expect(event: [ :event_date, :location ])
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
    if @event.creator_id != current_user.id # OR Current user is not invited!?
      flash[:notice] = "Sorry, you must be invited or the event creator to view this event."
      redirect_to root_path
    end
  end
end
