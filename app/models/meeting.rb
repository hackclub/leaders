class Meeting < ApplicationRecord
  belongs_to :club

  validate_presence_of :attendee_count, :start_time
end
