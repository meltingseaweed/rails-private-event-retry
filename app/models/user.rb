class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, foreign_key: "creator_id", class_name: "Event" # events?

  has_many :attendings, foreign_key: :attendee_id
  has_many :attended_events, through: :attendings

  has_many :invitations, foreign_key: :invited_users_id
  has_many :invited_events, through: :invitations
end
