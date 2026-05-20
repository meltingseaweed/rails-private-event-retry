class EventsController < ApplicationController
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
    @event = Event.find(params[:id])
  end

  private
  def event_params
    params.expect(event: [ :event_date, :location ])
  end
end
