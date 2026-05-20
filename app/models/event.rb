class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :attendings, foreign_key: :attended_events_id
  has_many :attendees, through: :attendings, source: :attendee

  scope :upcoming_events, ->(today) { where("event_date > ?", today) }
  scope :past_events, ->(today) { where("event_date < ?", today) }

  # def upcoming_event?(event)
  #   if event.event_date.after?(Date.today)
  #     true
  #   else
  #     false
  #   end
  # end

  # def past_event?(event)
  #   if event.event_date.before?(Date.today)
  #     true
  #   else
  #     false
  #   end
  # end
end
