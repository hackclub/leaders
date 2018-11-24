class Meeting < ApplicationRecord
  belongs_to :club

  validates_presence_of :attendee_count, :start_time
end
