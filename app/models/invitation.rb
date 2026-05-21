class Invitation < ApplicationRecord
  belongs_to :invited_users, class_name: "User"
  belongs_to :invited_events, class_name: "Event"
end
